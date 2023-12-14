import '../data/withdraw_from.dart';
import '../data/withdraw_method.dart';

abstract class WithdrawMoneyEvent {}

class InitEvent extends WithdrawMoneyEvent {}
class SubmitTransfer extends WithdrawMoneyEvent {}
class ChangeWallets extends WithdrawMoneyEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}
class ChangeMethods extends WithdrawMoneyEvent {
  Methods? methods;

  ChangeMethods(this.methods);
}