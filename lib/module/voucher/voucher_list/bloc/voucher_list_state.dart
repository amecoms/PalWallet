import '../../../../app_helper/enums.dart';
import '../data/voucher_list.dart';

class VoucherListState {
  VoucherList? transfers;
  PageState pageState;


  VoucherListState({this.transfers, this.pageState = PageState.Loading});

  VoucherListState init() {
    return VoucherListState();
  }

  VoucherListState clone({VoucherList? transfers, PageState? pageState}) {
    return VoucherListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
