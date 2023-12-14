import 'package:genius_wallet/module/payment/merchant_payment/data/payment_from.dart';
import 'package:genius_wallet/module/payment/payment_list/data/payment_history.dart';
import 'package:genius_wallet/module/transfer/transfer_money/data/receiver_check.dart';

import '../app_helper/api_client.dart';
import '../utils/url.dart';

class MerchantPaymentRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getPaymentList({String? url, required Function(PaymentHistory) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.merchantPaymentHistory,
      onSuccess: (Map<String,dynamic> data) {
        PaymentHistory transfers = PaymentHistory.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getPaymentFrom({required Function(PaymentFrom) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.paymentFrom,
      onSuccess: (Map<String,dynamic> data) {
        PaymentFrom transfers = PaymentFrom.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future checkMerchant({required String email, required Function(ReceiverCheck) onSuccess,required Function(ReceiverCheck) onError}) async {
    await apiClient.Request(
      url: URL.checkMerchant,
      method: Method.POST,
      body: {
        'receiver': email
      },
      enableShowError: false,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(ReceiverCheck.fromJson(data));
      },
      onError: (data)=> onError(ReceiverCheck.fromJson(data))
    );
  }

  Future submitPayment({required Map<String, String> body, required Function(Map<String, dynamic>) onSuccess,required Function(Map<String, dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.paymentFrom,
      method: Method.POST,
      body: body,
      enableShowError: false,
      onSuccess: onSuccess,
      onError: onError
    );
  }

}