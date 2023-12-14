import '../../../../app_helper/enums.dart';
import '../data/voucher_data.dart';


class CreateVoucherState {
  VoucherData? voucherData;
  Wallets? selectedWallets;
  PageState pageState;


  CreateVoucherState({this.voucherData, this.selectedWallets, this.pageState = PageState.Initial});

  CreateVoucherState init() {
    return CreateVoucherState();
  }

  CreateVoucherState clone({VoucherData? voucherData, Wallets? selectedWallets, PageState? pageState}) {
    return CreateVoucherState(
      voucherData: voucherData ?? this.voucherData,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
