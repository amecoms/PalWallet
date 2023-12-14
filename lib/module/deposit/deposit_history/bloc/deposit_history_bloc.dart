import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/deposit_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../utils/url.dart';
import 'deposit_history_event.dart';
import 'deposit_history_state.dart';

class DepositHistoryBloc extends Bloc<DepositHistoryEvent, DepositHistoryState> {
  DepositRepository repository = DepositRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  DepositHistoryBloc() : super(DepositHistoryState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<DepositHistoryState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.depositHistory;
  }

  FutureOr<void> _getData(GetData event, Emitter<DepositHistoryState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getDepositList(
      url: url,
      onSuccess: (data){
        url = data.response!.deposits!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.deposits!.data!.addAll(data.response!.deposits!.data!);
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
