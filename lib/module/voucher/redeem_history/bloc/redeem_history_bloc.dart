import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/voucher_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../utils/url.dart';
import 'redeem_history_event.dart';
import 'redeem_history_state.dart';

class RedeemHistoryBloc extends Bloc<RedeemHistoryEvent, RedeemHistoryState> {
  VoucherRepository repository = VoucherRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  RedeemHistoryBloc() : super(RedeemHistoryState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<RedeemHistoryState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.redeemHistory;
  }

  FutureOr<void> _getData(GetData event, Emitter<RedeemHistoryState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getRedeemHistory(
      url: url,
      onSuccess: (data){
        url = data.response!.history!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.history!.data!.addAll(data.response!.history!.data!);
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
