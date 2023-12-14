
import '../data/excrow_data.dart';

abstract class MakeEscrowEvent {}

class InitEvent extends MakeEscrowEvent {}
class SubmitTransfer extends MakeEscrowEvent {}
class ChangeWallets extends MakeEscrowEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}