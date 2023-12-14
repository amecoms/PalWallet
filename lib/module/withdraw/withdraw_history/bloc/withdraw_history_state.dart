import '../../../../app_helper/enums.dart';
import '../data/withdraw_history.dart';

class WithdrawHistoryState {
  WithdrawHistory? transfers;
  PageState pageState;


  WithdrawHistoryState({this.transfers, this.pageState = PageState.Loading});

  WithdrawHistoryState init() {
    return WithdrawHistoryState();
  }

  WithdrawHistoryState clone({WithdrawHistory? transfers, PageState? pageState}) {
    return WithdrawHistoryState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
