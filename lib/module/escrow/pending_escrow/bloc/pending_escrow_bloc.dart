import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/escrow_repository.dart';
import '../../../../utils/url.dart';
import 'pending_escrow_event.dart';
import 'pending_escrow_state.dart';

class PendingEscrowBloc extends Bloc<PendingEscrowEvent, PendingEscrowState> {
  EscrowRepository repository = EscrowRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  PendingEscrowBloc() : super(PendingEscrowState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<PendingEscrowState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.pendingEscrow;
  }

  FutureOr<void> _getData(GetData event, Emitter<PendingEscrowState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getPendingEscrow(
      url: url,
      onSuccess: (data){
        url = data.response!.escrows!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.escrows!.data!.addAll(data.response!.escrows!.data!);
          emit(state.clone(pageState: PageState.Success));
        } else {
          emit(state.clone(pageState: PageState.Success, transfers: data));
        }
      },
      onError:(data){}
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }
}
