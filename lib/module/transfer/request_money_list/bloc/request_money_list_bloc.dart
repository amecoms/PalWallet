import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'request_money_list_event.dart';
import 'request_money_list_state.dart';

class RequestMoneyListBloc extends Bloc<RequestMoneyListEvent, RequestMoneyListState> {
  TransferRepository repository = TransferRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  RequestMoneyListBloc() : super(RequestMoneyListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<RequestMoneyListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.requestMoneyLog;
  }

  FutureOr<void> _getData(GetData event, Emitter<RequestMoneyListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getRequestMoneyList(
      url: url,
      onSuccess: (data){
        url = data.response!.sentMoneyRequests!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.sentMoneyRequests!.data!.addAll(data.response!.sentMoneyRequests!.data!);
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
