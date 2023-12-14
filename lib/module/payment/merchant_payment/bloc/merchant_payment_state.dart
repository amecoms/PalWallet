import '../../../../app_helper/enums.dart';
import '../../../transfer/transfer_money/data/receiver_check.dart';
import '../data/payment_from.dart';


class MerchantPaymentState {
  PaymentFrom? moneyFrom;
  Wallets? selectedWallets;
  ReceiverCheck? receiverCheck;
  PageState pageState;


  MerchantPaymentState({this.moneyFrom, this.receiverCheck, this.selectedWallets, this.pageState = PageState.Initial});

  MerchantPaymentState init() {
    return MerchantPaymentState();
  }

  MerchantPaymentState clone({PaymentFrom? moneyFrom,ReceiverCheck? receiverCheck, Wallets? selectedWallets, PageState? pageState}) {
    return MerchantPaymentState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      receiverCheck: receiverCheck ?? this.receiverCheck,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
