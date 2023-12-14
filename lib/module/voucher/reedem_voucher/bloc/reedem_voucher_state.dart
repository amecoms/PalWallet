import '../../../../app_helper/enums.dart';
import '../data/voucher_data.dart';


class ReedemVoucherState {
  VoucherData? voucherData;
  PageState pageState;


  ReedemVoucherState({this.voucherData,this.pageState = PageState.Initial});

  ReedemVoucherState init() {
    return ReedemVoucherState();
  }

  ReedemVoucherState clone({VoucherData? voucherData, PageState? pageState}) {
    return ReedemVoucherState(
      voucherData: voucherData ?? this.voucherData,
      pageState: pageState ?? this.pageState
    );
  }
}
