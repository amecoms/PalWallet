import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'received_request_list_event.dart';
import 'received_request_list_state.dart';

class ReceivedRequestListBloc extends Bloc<ReceivedRequestListEvent, ReceivedRequestListState> {
  TransferRepository repository = TransferRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  ReceivedRequestListBloc() : super(ReceivedRequestListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<ChangeStatus>(_changeStatus);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ReceivedRequestListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.receivedRequestLog;
  }

  FutureOr<void> _getData(GetData event, Emitter<ReceivedRequestListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getReceivedRequestList(
      url: url,
      onSuccess: (data){
        url = data.response!.receivedMoneyRequests!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.receivedMoneyRequests!.data!.addAll(data.response!.receivedMoneyRequests!.data!);
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

  FutureOr<void> _changeStatus(ChangeStatus event, Emitter<ReceivedRequestListState> emit) async {
    await repository.changeRequestMoneyStatus(
      url: event.isApproved ? URL.acceptRequestMoney : URL.rejectRequestMoney,
      body: {
        'id':event.data.id.toString(),
        'sender_id': event.data.sender!.id.toString()
      },
      onSuccess: (data){
        state.transfers!.response!.receivedMoneyRequests!.data![event.index].status = event.isApproved ? '1' : '2';
        emit(state.clone());
      },
      onError: (data){}
    );
  }
}
