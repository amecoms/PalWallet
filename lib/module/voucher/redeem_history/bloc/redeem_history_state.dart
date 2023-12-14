import '../../../../app_helper/enums.dart';
import '../data/redeem_history.dart';

class RedeemHistoryState {
  RedeemHistory? transfers;
  PageState pageState;


  RedeemHistoryState({this.transfers, this.pageState = PageState.Loading});

  RedeemHistoryState init() {
    return RedeemHistoryState();
  }

  RedeemHistoryState clone({RedeemHistory? transfers, PageState? pageState}) {
    return RedeemHistoryState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
