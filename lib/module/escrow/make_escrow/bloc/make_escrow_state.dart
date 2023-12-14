import '../../../../app_helper/enums.dart';
import '../../../transfer/transfer_money/data/receiver_check.dart';
import '../data/excrow_data.dart';


class MakeEscrowState {
  ExcrowData? moneyFrom;
  Wallets? selectedWallets;
  ReceiverCheck? receiverCheck;
  PageState pageState;


  MakeEscrowState({this.moneyFrom, this.receiverCheck, this.selectedWallets, this.pageState = PageState.Initial});

  MakeEscrowState init() {
    return MakeEscrowState();
  }

  MakeEscrowState clone({ExcrowData? moneyFrom, ReceiverCheck? receiverCheck, Wallets? selectedWallets, PageState? pageState}) {
    return MakeEscrowState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      receiverCheck: receiverCheck ?? this.receiverCheck,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
