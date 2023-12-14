import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/merchant_payment_repository.dart';
import '../../../../utils/url.dart';
import 'payment_list_event.dart';
import 'payment_list_state.dart';

class PaymentHistoryBloc extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  MerchantPaymentRepository repository = MerchantPaymentRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  PaymentHistoryBloc() : super(PaymentHistoryState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<PaymentHistoryState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.merchantPaymentHistory;
  }

  FutureOr<void> _getData(GetData event, Emitter<PaymentHistoryState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getPaymentList(
      url: url,
      onSuccess: (data){
        url = data.response!.payments!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.payments!.data!.addAll(data.response!.payments!.data!);
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
