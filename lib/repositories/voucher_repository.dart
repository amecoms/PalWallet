import 'package:genius_wallet/module/voucher/create_voucher/data/voucher_data.dart';
import 'package:genius_wallet/module/voucher/redeem_history/data/redeem_history.dart';
import 'package:genius_wallet/module/voucher/reedem_voucher/data/voucher_data.dart' as RD;
import 'package:genius_wallet/module/voucher/voucher_list/data/voucher_list.dart';

import '../app_helper/api_client.dart';
import '../utils/url.dart';

class VoucherRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getVoucherList({String? url, required Function(VoucherList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.voucherList,
      onSuccess: (Map<String,dynamic> data) {
        VoucherList transfers = VoucherList.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getRedeemHistory({String? url, required Function(RedeemHistory) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.redeemHistory,
      onSuccess: (Map<String,dynamic> data) {
        RedeemHistory transfers = RedeemHistory.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getVoucherReedemData({required Function(RD.VoucherData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.redeemVoucherData,
      onSuccess: (Map<String,dynamic> data) {
        RD.VoucherData transfers = RD.VoucherData.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getVoucherData({required Function(VoucherData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.voucherData,
      onSuccess: (Map<String,dynamic> data) {
        VoucherData transfers = VoucherData.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future submitVoucherData({required Map<String, String> body, required Function(Map<String, dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.voucherData,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future submitRedeemVoucherData({required Map<String, String> body, required Function(Map<String, dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.redeemVoucherData,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

}