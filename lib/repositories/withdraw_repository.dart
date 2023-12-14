import 'package:genius_wallet/module/withdraw/withdraw_history/data/withdraw_history.dart';
import 'package:genius_wallet/module/withdraw/withdraw_money/data/withdraw_from.dart';

import '../app_helper/api_client.dart';
import '../module/withdraw/withdraw_money/data/withdraw_method.dart';
import '../utils/url.dart';


class WithdrawRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getWithdrawList({required String? url ,required Function(WithdrawHistory) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.withdrawList,
      onSuccess: (Map<String,dynamic> data) {
        WithdrawHistory transfers = WithdrawHistory.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getMethods({required String currencyId, required Function(WithdrawMethod) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.methods+currencyId,
      onSuccess: (Map<String,dynamic> data) {
        WithdrawMethod methods = WithdrawMethod.fromJson(data);
        onSuccess(methods);
      },
      onError: onError
    );
  }

  Future getFrom({required Function(WithdrawFrom) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.withdrawFrom,
      onSuccess: (Map<String,dynamic> data) {
        WithdrawFrom methods = WithdrawFrom.fromJson(data);
        onSuccess(methods);
      },
      onError: onError
    );
  }

  Future submitTransfer({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.submitWithdraw,
      method: Method.POST,
      body: body,
      onSuccess: onSuccess,
      onError: onError
    );
  }
}