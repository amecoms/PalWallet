import '../../../../app_helper/enums.dart';
import '../../transfer_money/data/transfer_log.dart';

class TransferListState {
  TransferLog? transfers;
  PageState pageState;


  TransferListState({this.transfers, this.pageState = PageState.Loading});

  TransferListState init() {
    return TransferListState();
  }

  TransferListState clone({TransferLog? transfers, PageState? pageState}) {
    return TransferListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
