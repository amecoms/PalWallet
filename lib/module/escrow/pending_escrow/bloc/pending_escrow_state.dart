import '../data/pending_list.dart';

import '../../../../app_helper/enums.dart';

class PendingEscrowState {
  PendingList? transfers;
  PageState pageState;


  PendingEscrowState({this.transfers, this.pageState = PageState.Loading});

  PendingEscrowState init() {
    return PendingEscrowState();
  }

  PendingEscrowState clone({PendingList? transfers, PageState? pageState}) {
    return PendingEscrowState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
