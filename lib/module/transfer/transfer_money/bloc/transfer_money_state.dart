import 'package:genius_wallet/module/transfer/transfer_money/data/money_from.dart';

import '../../../../app_helper/enums.dart';
import '../data/receiver_check.dart';
import '../data/transfer_log.dart';


class TransferMoneyState {
  MoneyFrom? moneyFrom;
  TransferLog? transferLog;
  Wallets? selectedWallets;
  ReceiverCheck? receiverCheck;
  PageState pageState;


  TransferMoneyState({this.moneyFrom, this.transferLog, this.receiverCheck, this.selectedWallets, this.pageState = PageState.Initial});

  TransferMoneyState init() {
    return TransferMoneyState();
  }

  TransferMoneyState clone({MoneyFrom? moneyFrom, TransferLog? transferLog, ReceiverCheck? receiverCheck, Wallets? selectedWallets, PageState? pageState}) {
    return TransferMoneyState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      transferLog: transferLog ?? this.transferLog,
      receiverCheck: receiverCheck ?? this.receiverCheck,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
