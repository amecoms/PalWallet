import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/escrow_repository.dart';
import '../../../../utils/url.dart';
import 'my_escrow_event.dart';
import 'my_escrow_state.dart';

class MyEscrowBloc extends Bloc<MyEscrowEvent, MyEscrowState> {
  EscrowRepository repository = EscrowRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  MyEscrowBloc() : super(MyEscrowState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<ReleaseEscrow>(_releaseEscrow);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MyEscrowState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.myEscrow;
  }

  FutureOr<void> _getData(GetData event, Emitter<MyEscrowState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getMyEscrow(
      url: url,
      onSuccess: (data){
        url = data.response!.escrows!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.escrows!.data!.addAll(data.response!.escrows!.data!);
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

  FutureOr<void> _releaseEscrow(ReleaseEscrow event, Emitter<MyEscrowState> emit) async {
    state.transfers!.response!.escrows!.data![event.index].isLoading = true;
    emit(state.clone());
    await repository.releaseEscrow(
        id: state.transfers!.response!.escrows!.data![event.index].id.toString(),
        onSuccess: (data){
          state.transfers!.response!.escrows!.data![event.index].status = '1';
        },
        onError:(data){}
    );
    state.transfers!.response!.escrows!.data![event.index].isLoading = false;
    emit(state.clone());
  }
}
