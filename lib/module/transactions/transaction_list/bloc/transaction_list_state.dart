import 'package:genius_wallet/module/transactions/transaction_list/data/transactions.dart';

import '../../../../app_helper/enums.dart';

class TransactionListState {
  Transactions? transfers;
  PageState pageState;
  String? selectedRemark,trxId;


  TransactionListState({this.transfers, this.pageState = PageState.Loading, this.trxId, this.selectedRemark});

  TransactionListState init() {
    return TransactionListState();
  }

  TransactionListState clone({Transactions? transfers, PageState? pageState, String? selectedRemark, String? trxId}) {
    return TransactionListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers,
      selectedRemark: selectedRemark,
      trxId: trxId
    );
  }
}
