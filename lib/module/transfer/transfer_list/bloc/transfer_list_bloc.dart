import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'transfer_list_event.dart';
import 'transfer_list_state.dart';

class TransferListBloc extends Bloc<TransferListEvent, TransferListState> {
  TransferRepository repository = TransferRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  TransferListBloc() : super(TransferListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TransferListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.transferLog;
  }

  FutureOr<void> _getData(GetData event, Emitter<TransferListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getTransferList(
      url: url,
      onSuccess: (data){
        url = data.response!.transferHistory!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.transferHistory!.data!.addAll(data.response!.transferHistory!.data!);
          emit(state.clone(pageState: PageState.Success));
        } else {
          emit(state.clone(pageState: PageState.Success, transfers: data));
        }
      },
      onError:(data){}
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }
}
