import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';

import '../app_helper/api_client.dart';
import '../module/deposit/deposit_history/data/deposit_list.dart';
import '../module/deposit/deposit_money/data/deposit_from.dart';
import '../utils/app_constant.dart';
import '../utils/url.dart';

class DepositRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getDepositFrom({required Function(DepositFrom) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.depositFrom,
      onSuccess: (Map<String,dynamic> data) {
        DepositFrom deposit = DepositFrom.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }

  Future getDepositGateways({required String currency,required Function(Gateways) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.depositGateways+currency,
      onSuccess: (Map<String,dynamic> data) {
        Gateways deposit = Gateways.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }

  Future getDepositList({String? url, required Function(DepositList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.depositHistory,
      onSuccess: (Map<String,dynamic> data) {
        DepositList deposit = DepositList.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }

  Future submitDeposit({required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.submitDeposit,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }
}