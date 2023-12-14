import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/ticket_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'support_list_event.dart';
import 'support_list_state.dart';

class SupportListBloc extends Bloc<SupportListEvent, SupportListState> {
  TicketRepository repository = TicketRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  SupportListBloc() : super(SupportListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<OpenTicket>(_openTicket);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SupportListState> emit) async {
    state.tickets = null;
    emit(state.clone());
    url = URL.tickets;
  }

  FutureOr<void> _getData(GetData event, Emitter<SupportListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getTicketList(
      url: url,
      onSuccess: (data){
        url = data.response!.tickets!.nextPageUrl;
        if(state.tickets!=null){
          state.tickets!.response!.tickets!.data!.addAll(data.response!.tickets!.data!);
          emit(state.clone(pageState: PageState.Success));
        } else {
          emit(state.clone(pageState: PageState.Success, tickets: data));
        }
      },
      onError:(data){}
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  FutureOr<void> _openTicket(OpenTicket event, Emitter<SupportListState> emit) async {
    await repository.openTicket(
        subject: event.subject,
        onSuccess: (data){
          add(InitEvent());
          add(GetData());
        },
        onError:(data){}
    );
  }
}
