import 'package:genius_wallet/module/exchange/exchange_list/data/exchange_list.dart';

import '../app_helper/api_client.dart';
import '../module/exchange/exchange_money/data/exchange_data.dart' as ED;
import '../utils/url.dart';

class ExchangeRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getExchangeList({String? url, required Function(ExchangeList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.exchangeList,
      onSuccess: (Map<String,dynamic> data) {
        ExchangeList transfers = ExchangeList.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getExchangeData({required Function(ED.ExchangeData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.exchangeData,
      onSuccess: (Map<String,dynamic> data) {
        ED.ExchangeData transfers = ED.ExchangeData.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future submitExchangeData({required Map<String, String> body, required Function(Map<String, dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.exchangeData,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

}