import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';
import 'package:genius_wallet/module/invoice/create_invoice/data/invoice_currency.dart';
import 'package:genius_wallet/module/invoice/invoice_list/data/invoice_history.dart';

import '../app_helper/api_client.dart';
import '../module/deposit/deposit_money/data/deposit_from.dart';
import '../module/invoice/invoice_list/data/invoice_details.dart';
import '../utils/app_constant.dart';
import '../utils/url.dart';

class InvoiceRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getInvoices({String? url, required Function(InvoiceHistory) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: url ?? URL.invoices,
        onSuccess: (Map<String,dynamic> data) {
          InvoiceHistory transfers = InvoiceHistory.fromJson(data);
          onSuccess(transfers);
        },
        onError: onError
    );
  }

  Future getInvoiceFrom({required Function(InvoiceCurrency) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.invoice,
      onSuccess: (Map<String,dynamic> data) {
        InvoiceCurrency deposit = InvoiceCurrency.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }

  Future submitInvoice({required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.invoice,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future updateInvoice({required String invoiceId, required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.invoiceUpdate+invoiceId,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future sendEmail({required String invoiceId,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.invoiceSendEmail+invoiceId,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future cancelInvoice({required String invoiceId,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.cancelInvoice+invoiceId,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future changePaymentStatus({required String id,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.changePaymentStatus,
      method: Method.POST,
      body: {
        'id':id
      },
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future changePublishStatus({required String id,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.changePublishStatus,
      method: Method.POST,
      body: {
        'id':id
      },
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future invoiceDetails({required String invoiceNumber,required Function(InvoiceDetails) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.invoiceDetails+invoiceNumber,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(InvoiceDetails.fromJson(data));
      },
      onError: onError
    );
  }
}