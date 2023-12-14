import '../../../../app_helper/enums.dart';
import '../../transfer_money/data/receiver_check.dart';
import '../data/request_money_data.dart';


class RequestMoneyState {
  RequestMoneyData? moneyFrom;
  Wallets? selectedWallets;
  ReceiverCheck? receiverCheck;
  PageState pageState;


  RequestMoneyState({this.moneyFrom, this.receiverCheck, this.selectedWallets, this.pageState = PageState.Initial});

  RequestMoneyState init() {
    return RequestMoneyState();
  }

  RequestMoneyState clone({RequestMoneyData? moneyFrom, ReceiverCheck? receiverCheck, Wallets? selectedWallets, PageState? pageState}) {
    return RequestMoneyState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      receiverCheck: receiverCheck ?? this.receiverCheck,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
