import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/voucher_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../utils/url.dart';
import 'voucher_list_event.dart';
import 'voucher_list_state.dart';

class VoucherListBloc extends Bloc<VoucherListEvent, VoucherListState> {
  VoucherRepository repository = VoucherRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  VoucherListBloc() : super(VoucherListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<VoucherListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.voucherList;
  }

  FutureOr<void> _getData(GetData event, Emitter<VoucherListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getVoucherList(
      url: url,
      onSuccess: (data){
        url = data.response!.vouchers!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.vouchers!.data!.addAll(data.response!.vouchers!.data!);
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
