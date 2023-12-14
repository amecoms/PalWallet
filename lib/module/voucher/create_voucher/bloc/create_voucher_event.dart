import '../data/voucher_data.dart';

abstract class CreateVoucherEvent {}

class InitEvent extends CreateVoucherEvent {}
class SubmitTransfer extends CreateVoucherEvent {}
class ChangeWallets extends CreateVoucherEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}