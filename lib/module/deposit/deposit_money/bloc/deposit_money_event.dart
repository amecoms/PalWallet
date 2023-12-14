import '../data/gateways.dart';

import '../data/deposit_from.dart';

abstract class DepositMoneyEvent {}

class InitEvent extends DepositMoneyEvent {}
class SubmitTransfer extends DepositMoneyEvent {}
class ChangeWallets extends DepositMoneyEvent {
  Wallets? wallets;
  ChangeWallets(this.wallets);
}
class ChangeMethod extends DepositMoneyEvent {
  Methods? methods;
  ChangeMethod(this.methods);
}