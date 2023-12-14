

abstract class InvoiceListEvent {}

class InitEvent extends InvoiceListEvent {}
class GetData extends InvoiceListEvent {}
class UpdateInvoice extends InvoiceListEvent {
  int index;

  UpdateInvoice(this.index);
}
class GetInvoiceDetails extends InvoiceListEvent {
  String invoiceNumber;

  GetInvoiceDetails(this.invoiceNumber);
}
class ChangePaymentStatus extends InvoiceListEvent {
  int index;

  ChangePaymentStatus(this.index);
}
class ChangePublishStatus extends InvoiceListEvent {
  int index;

  ChangePublishStatus(this.index);
}