import '../data/payment_from.dart';

abstract class MerchantPaymentEvent {}

class InitEvent extends MerchantPaymentEvent {}
class SubmitTransfer extends MerchantPaymentEvent {}
class ChangeWallets extends MerchantPaymentEvent {
  Wallets? wallets;

  ChangeWallets(this.wallets);
}