import 'package:flutter/material.dart';

import '../data/invoice_currency.dart';

abstract class CreateInvoiceEvent {}

class InitEvent extends CreateInvoiceEvent {
  BuildContext context;

  InitEvent(this.context);
}
class SubmitTransfer extends CreateInvoiceEvent {}
class SendEmail extends CreateInvoiceEvent {}
class CancelInvoice extends CreateInvoiceEvent {}
class ChangeItems extends CreateInvoiceEvent {
  int? removeIndex;
  ChangeItems({this.removeIndex});
}
class ChangeWallets extends CreateInvoiceEvent {
  Currencies? wallets;
  ChangeWallets(this.wallets);
}