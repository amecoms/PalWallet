import 'package:genius_wallet/module/invoice/create_invoice/data/invoice_currency.dart';

import '../../../../app_helper/enums.dart';
import '../../invoice_list/data/invoice_details.dart';
import '../../invoice_list/data/invoice_history.dart';


class CreateInvoiceState {
  InvoiceCurrency? moneyFrom;
  Currencies? selectedWallets;
  PageState pageState, sendEmailState, cancelInvoiceState;
  InvoiceData? invoiceData;
  InvoiceDetails? invoiceDetails;
  bool isEdit;


  CreateInvoiceState({this.moneyFrom, this.selectedWallets, this.pageState = PageState.Initial, this.invoiceData, this.isEdit = false, this.invoiceDetails, this.sendEmailState = PageState.Initial, this.cancelInvoiceState= PageState.Initial});

  CreateInvoiceState init() {
    return CreateInvoiceState();
  }

  CreateInvoiceState clone({InvoiceCurrency? moneyFrom, Currencies? selectedWallets, PageState? pageState, InvoiceData? invoiceData, bool? isEdit, InvoiceDetails? invoiceDetails, PageState? sendEmailState, PageState? cancelInvoiceState}) {
    return CreateInvoiceState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState,
      invoiceData: invoiceData ?? this.invoiceData,
      isEdit: isEdit ?? this.isEdit,
      invoiceDetails: invoiceDetails ?? this.invoiceDetails,
      sendEmailState: sendEmailState ?? this.sendEmailState,
      cancelInvoiceState: cancelInvoiceState ?? this.cancelInvoiceState
    );
  }
}
