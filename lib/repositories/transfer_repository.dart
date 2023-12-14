import 'package:genius_wallet/module/transfer/request_money_list/data/request_list.dart';
import 'package:genius_wallet/module/transfer/received_request_list/data/request_list.dart' as RR;
import 'package:genius_wallet/module/transfer/transfer_money/data/receiver_check.dart';

import '../app_helper/api_client.dart';
import '../module/transfer/request_money/data/request_money_data.dart';
import '../module/transfer/transfer_money/data/money_from.dart';
import '../module/transfer/transfer_money/data/transfer_log.dart';
import '../utils/url.dart';

class TransferRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getTransferList({String? url, required Function(TransferLog) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.transferLog,
      onSuccess: (Map<String,dynamic> data) {
        TransferLog transfers = TransferLog.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getRequestMoneyList({String? url, required Function(RequestList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.requestMoneyLog,
      onSuccess: (Map<String,dynamic> data) {
        RequestList transfers = RequestList.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getReceivedRequestList({String? url, required Function(RR.RequestList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.receivedRequestLog,
      onSuccess: (Map<String,dynamic> data) {
        RR.RequestList transfers = RR.RequestList.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future changeRequestMoneyStatus({required String url, required Map<String, String> body, required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future getTransferMoneyFrom({required Function(MoneyFrom) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.transferMoneyFrom,
      onSuccess: (Map<String,dynamic> data) {
        MoneyFrom banks = MoneyFrom.fromJson(data);
        onSuccess(banks);
      },
      onError: onError
    );
  }

  Future getRequestMoneyFrom({required Function(RequestMoneyData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.requestMoneyFrom,
      onSuccess: (Map<String,dynamic> data) {
        RequestMoneyData banks = RequestMoneyData.fromJson(data);
        onSuccess(banks);
      },
      onError: onError
    );
  }
  Future checkReceiver({required String email,required Function(ReceiverCheck) onSuccess,required Function(ReceiverCheck) onError}) async {
    await apiClient.Request(
      url: URL.checkReceiver,
      method: Method.POST,
      body: {
        'receiver': email
      },
      enableShowError: false,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(ReceiverCheck.fromJson(data));
      },
      onError: (data)=>onError(ReceiverCheck.fromJson(data))
    );
  }
  Future submitTransfer({required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.submitTransfer,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future submitRequest({required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.submitRequest,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }



}