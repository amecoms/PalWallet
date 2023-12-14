
import '../data/exchange_data.dart';

abstract class ExchangeMoneyEvent {}

class InitEvent extends ExchangeMoneyEvent {}
class SubmitTransfer extends ExchangeMoneyEvent {}
class ChangeWallets extends ExchangeMoneyEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}
class ChangeToWallets extends ExchangeMoneyEvent {
  Currencies? wallets;

  ChangeToWallets(this.wallets);
}