import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/exchange_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/url.dart';
import 'exchange_list_event.dart';
import 'exchange_list_state.dart';

class ExchangeListBloc extends Bloc<ExchangeListEvent, ExchangeListState> {
  ExchangeRepository repository = ExchangeRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  ExchangeListBloc() : super(ExchangeListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ExchangeListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.exchangeList;
  }

  FutureOr<void> _getData(GetData event, Emitter<ExchangeListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getExchangeList(
      url: url,
      onSuccess: (data){
        url = data.response!.exchanges!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.exchanges!.data!.addAll(data.response!.exchanges!.data!);
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
