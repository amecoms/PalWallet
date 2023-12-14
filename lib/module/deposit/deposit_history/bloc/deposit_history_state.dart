import '../../../../app_helper/enums.dart';
import '../data/deposit_list.dart';

class DepositHistoryState {
  DepositList? transfers;
  PageState pageState;


  DepositHistoryState({this.transfers, this.pageState = PageState.Loading});

  DepositHistoryState init() {
    return DepositHistoryState();
  }

  DepositHistoryState clone({DepositList? transfers, PageState? pageState}) {
    return DepositHistoryState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
