import 'dart:io';

import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';
import 'package:genius_wallet/module/escrow/escrow_dispute/data/escrow_dispute.dart';
import 'package:genius_wallet/module/escrow/my_escrow/data/escrow_list.dart';
import 'package:genius_wallet/module/escrow/pending_escrow/data/pending_list.dart';
import 'package:genius_wallet/module/invoice/create_invoice/data/invoice_currency.dart';

import '../app_helper/api_client.dart';
import '../module/deposit/deposit_money/data/deposit_from.dart';
import '../module/escrow/make_escrow/data/excrow_data.dart';
import '../utils/app_constant.dart';
import '../utils/url.dart';

class EscrowRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getEscrowFrom({required Function(ExcrowData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.escrowData,
      onSuccess: (Map<String,dynamic> data) {
        ExcrowData deposit = ExcrowData.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }


  Future getMyEscrow({String? url, required Function(EscrowList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: url ?? URL.myEscrow,
        onSuccess: (Map<String,dynamic> data) {
          EscrowList transfers = EscrowList.fromJson(data);
          onSuccess(transfers);
        },
        onError: onError
    );
  }


  Future getPendingEscrow({String? url, required Function(PendingList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: url ?? URL.pendingEscrow,
        onSuccess: (Map<String,dynamic> data) {
          PendingList transfers = PendingList.fromJson(data);
          onSuccess(transfers);
        },
        onError: onError
    );
  }


  Future getEscrowDispute({required String id, required Function(EscrowDispute) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.escrowDispute+id,
        onSuccess: (Map<String,dynamic> data) {
          EscrowDispute transfers = EscrowDispute.fromJson(data);
          onSuccess(transfers);
        },
        onError: onError
    );
  }

  Future releaseEscrow({required String id, required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.escrowRelease+id,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future submitDispute({
    required String id,
    required Map<String, String> body,
    required List<String> fileKeys,
    required List<File> files,
    required Function(Map<String,dynamic>) onSuccess,
    required Function(Map<String,dynamic>) onError}) async {
    await apiClient.RequestWithFile(
        url: URL.escrowDispute+id,
        body: body,
        method: Method.POST,
        fileKey: fileKeys,
        files: files,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(data);
        },
        onError: onError
    );
  }

  Future submitEscrow({required Map<String,String> body,required Function(Map<String,dynamic>) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.escrowData,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }
}