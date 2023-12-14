import '../../../../app_helper/enums.dart';
import '../../../transfer/transfer_money/data/receiver_check.dart';
import '../data/cashout_form.dart';


class CashOutState {
  CashOutForm? moneyFrom;
  Wallets? selectedWallets;
  ReceiverCheck? receiverCheck;
  PageState pageState;


  CashOutState({this.moneyFrom, this.receiverCheck, this.selectedWallets, this.pageState = PageState.Initial});

  CashOutState init() {
    return CashOutState();
  }

  CashOutState clone({CashOutForm? moneyFrom, ReceiverCheck? receiverCheck, Wallets? selectedWallets, PageState? pageState}) {
    return CashOutState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      receiverCheck: receiverCheck ?? this.receiverCheck,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
