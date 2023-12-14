import '../data/invoice_details.dart';
import '../data/invoice_history.dart';

import '../../../../app_helper/enums.dart';

class InvoiceListState {
  InvoiceHistory? transfers;
  PageState pageState, statusChangeState;
  InvoiceDetails? details;


  InvoiceListState({this.transfers, this.pageState = PageState.Loading, this.statusChangeState = PageState.Initial, this.details});

  InvoiceListState init() {
    return InvoiceListState();
  }

  InvoiceListState clone({InvoiceHistory? transfers, PageState? pageState, PageState? statusChangeState, InvoiceDetails? details}) {
    return InvoiceListState(
      pageState: pageState ?? this.pageState,
      statusChangeState: statusChangeState ?? this.statusChangeState,
      transfers: transfers ?? this.transfers,
      details: details ?? this.details
    );
  }
}
