import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transaction_repository.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'transaction_list_event.dart';
import 'transaction_list_state.dart';

class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  TransactionRepository repository = TransactionRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  TransactionListBloc() : super(TransactionListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<ChangeFilter>(_applyFilter);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TransactionListState> emit) async {
    state.transfers?.response?.transactions?.data?.clear();
    url = URL.allTransactions(search: state.trxId,remark: state.selectedRemark,page: 1);
    emit(state.clone(
      trxId: state.trxId,
      selectedRemark: state.selectedRemark
    ));
  }

  FutureOr<void> _getData(GetData event, Emitter<TransactionListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getTransactions(
      url: url,
      onSuccess: (data){
        if(data.response!.transactions!.nextPageUrl != null) {
          int page = Uri.parse(url!).queryParameters['page']?.toInt ?? 1;
          url = URL.allTransactions(search: state.trxId,remark: state.selectedRemark,page: page+1);
        } else {
          url = null;
        }
        if(state.transfers!=null){
          state.transfers!.response!.transactions!.data!.addAll(data.response!.transactions!.data!);
          emit(state.clone(pageState: PageState.Success,selectedRemark: data.response!.remark, trxId: data.response!.search));
        } else {
          emit(state.clone(pageState: PageState.Success, transfers: data,selectedRemark: data.response!.remark, trxId: data.response!.search));
        }
      },
      onError:(data){}
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  FutureOr<void> _applyFilter(ChangeFilter event, Emitter<TransactionListState> emit) {
    emit(state.clone(selectedRemark: event.remark,trxId: event.trxId));
    refreshController.requestRefresh();
  }
}
