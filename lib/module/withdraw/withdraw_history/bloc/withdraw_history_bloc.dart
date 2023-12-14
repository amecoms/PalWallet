import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/withdraw_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'withdraw_history_event.dart';
import 'withdraw_history_state.dart';

class WithdrawHistoryBloc extends Bloc<WithdrawHistoryEvent, WithdrawHistoryState> {
  WithdrawRepository repository = WithdrawRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  WithdrawHistoryBloc() : super(WithdrawHistoryState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<WithdrawHistoryState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.withdrawList;
  }

  FutureOr<void> _getData(GetData event, Emitter<WithdrawHistoryState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getWithdrawList(
      url: url,
      onSuccess: (data){
        url = data.response!.withdrawals!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.withdrawals!.data!.addAll(data.response!.withdrawals!.data!);
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
