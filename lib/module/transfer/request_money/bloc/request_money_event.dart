
import '../data/request_money_data.dart';

abstract class RequestMoneyEvent {}

class InitEvent extends RequestMoneyEvent {}
class SubmitTransfer extends RequestMoneyEvent {}
class ChangeWallets extends RequestMoneyEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}