import 'package:genius_wallet/module/withdraw/withdraw_history/data/withdraw_history.dart';
import 'package:genius_wallet/module/withdraw/withdraw_money/data/withdraw_from.dart';

import '../app_helper/api_client.dart';
import '../module/transfer/transfer_money/data/receiver_check.dart';
import '../module/withdraw/cashout/data/cashout_form.dart';
import '../module/withdraw/withdraw_money/data/withdraw_method.dart';
import '../utils/url.dart';


class CashOutRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future checkAgent({required String email, required Function(ReceiverCheck) onSuccess,required Function(ReceiverCheck) onError}) async {
    await apiClient.Request(
      url: URL.agentCheck,
      method: Method.POST,
      body: {
        'receiver': email
      },
      enableShowError: false,
      onSuccess: (Map<String,dynamic> data) {
        ReceiverCheck methods = ReceiverCheck.fromJson(data);
        onSuccess(methods);
      },
      onError: (data){
        ReceiverCheck methods = ReceiverCheck.fromJson(data);
        onError(methods);
      }
    );
  }

  Future getFrom({required Function(CashOutForm) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.cashOutFrom,
      onSuccess: (Map<String,dynamic> data) {
        CashOutForm methods = CashOutForm.fromJson(data);
        onSuccess(methods);
      },
      onError: onError
    );
  }

  Future submitTransfer({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.cashOutFrom,
      method: Method.POST,
      body: body,
      onSuccess: onSuccess,
      onError: onError
    );
  }
}