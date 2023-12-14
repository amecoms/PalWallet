import '../data/money_from.dart';

abstract class TransferMoneyEvent {}

class InitEvent extends TransferMoneyEvent {}
class SubmitTransfer extends TransferMoneyEvent {}
class ChangeWallets extends TransferMoneyEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}