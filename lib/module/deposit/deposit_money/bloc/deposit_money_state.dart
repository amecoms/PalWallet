import 'package:genius_wallet/module/deposit/deposit_money/data/deposit_from.dart';

import '../../../../app_helper/enums.dart';
import '../data/gateways.dart';


class DepositMoneyState {
  DepositFrom? moneyFrom;
  Wallets? selectedWallets;
  PageState pageState;
  Gateways? gateways;
  Methods? selectedGateway;


  DepositMoneyState({this.moneyFrom, this.selectedWallets, this.pageState = PageState.Initial, this.gateways, this.selectedGateway});

  DepositMoneyState init() {
    return DepositMoneyState();
  }

  DepositMoneyState clone({DepositFrom? moneyFrom, Wallets? selectedWallets, PageState? pageState, Gateways? gateways, Methods? selectedGateway}) {
    return DepositMoneyState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState,
      gateways: gateways ?? this.gateways,
      selectedGateway: selectedGateway ?? this.selectedGateway
    );
  }
}
