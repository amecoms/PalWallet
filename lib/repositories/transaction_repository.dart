import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';
import 'package:genius_wallet/module/invoice/create_invoice/data/invoice_currency.dart';
import 'package:genius_wallet/module/transactions/transaction_list/data/transactions.dart';

import '../app_helper/api_client.dart';
import '../module/deposit/deposit_money/data/deposit_from.dart';
import '../utils/app_constant.dart';
import '../utils/url.dart';

class TransactionRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getTransactions({required String? url,required Function(Transactions) onSuccess,required Function(Map<String,dynamic>) onError,}) async {
    await apiClient.Request(
      url: url ?? URL.allTransactions(page: 1),
      onSuccess: (Map<String,dynamic> data) {
        Transactions deposit = Transactions.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }
}