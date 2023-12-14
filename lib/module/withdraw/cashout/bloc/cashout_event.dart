import '../data/cashout_form.dart';

abstract class CashOutEvent {}

class InitEvent extends CashOutEvent {}
class SubmitTransfer extends CashOutEvent {}
class ChangeWallets extends CashOutEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}