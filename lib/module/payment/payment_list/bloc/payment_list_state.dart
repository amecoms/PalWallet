import '../../../../app_helper/enums.dart';
import '../data/payment_history.dart';

class PaymentHistoryState {
  PaymentHistory? transfers;
  PageState pageState;


  PaymentHistoryState({this.transfers, this.pageState = PageState.Loading});

  PaymentHistoryState init() {
    return PaymentHistoryState();
  }

  PaymentHistoryState clone({PaymentHistory? transfers, PageState? pageState}) {
    return PaymentHistoryState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
