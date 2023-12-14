import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/module/invoice/invoice_list/data/invoice_history.dart';
import 'package:genius_wallet/repositories/invoice_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../repositories/escrow_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/url.dart';
import 'invoice_list_event.dart';
import 'invoice_list_state.dart';

class InvoiceListBloc extends Bloc<InvoiceListEvent, InvoiceListState> {
  InvoiceRepository repository = InvoiceRepository();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  String? url;

  InvoiceListBloc() : super(InvoiceListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<ChangePaymentStatus>(_changePaymentStatus);
    on<ChangePublishStatus>(_changePublishStatus);
    on<GetInvoiceDetails>(_getInvoiceDetails);
    on<UpdateInvoice>(_updateInvoice);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<InvoiceListState> emit) async {
    state.transfers = null;
    emit(state.clone());
    url = URL.invoices;
  }

  FutureOr<void> _getData(GetData event, Emitter<InvoiceListState> emit) async {
    if(url == null){
      refreshController.loadNoData();
      return;
    }
    await repository.getInvoices(
      url: url,
      onSuccess: (data){
        url = data.response!.invoices!.nextPageUrl;
        if(state.transfers!=null){
          state.transfers!.response!.invoices!.data!.addAll(data.response!.invoices!.data!);
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

  FutureOr<void> _changePaymentStatus(ChangePaymentStatus event, Emitter<InvoiceListState> emit) async {
    emit(state.clone(statusChangeState: PageState.Loading));
    await repository.changePaymentStatus(
      id: state.transfers!.response!.invoices!.data![event.index].id.toString(),
      onSuccess: (data){
        SuccessMessage(message: data['message']);
        if(data['response'].contains('paid')){
          state.transfers!.response!.invoices!.data![event.index].paymentStatus = '1';
        } else {
          state.transfers!.response!.invoices!.data![event.index].paymentStatus = '0';
        }
      },
      onError: (data){}
    );
    emit(state.clone(statusChangeState: PageState.Success));
  }

  FutureOr<void> _changePublishStatus(ChangePublishStatus event, Emitter<InvoiceListState> emit) async {
    emit(state.clone(statusChangeState: PageState.Loading));
    await repository.changePublishStatus(
        id: state.transfers!.response!.invoices!.data![event.index].id.toString(),
        onSuccess: (data){
          SuccessMessage(message: data['message']);
          if(data['response'].contains('publish')){
            state.transfers!.response!.invoices!.data![event.index].status = '1';
          } else {
            state.transfers!.response!.invoices!.data![event.index].status = '0';
          }
        },
        onError: (data){}
    );
    emit(state.clone(statusChangeState: PageState.Success));
  }

  FutureOr<void> _getInvoiceDetails(GetInvoiceDetails event, Emitter<InvoiceListState> emit) async {
    state.details = null;
    emit(state.clone());
    await repository.invoiceDetails(
      invoiceNumber: event.invoiceNumber,
      onSuccess: (data){
        emit(state.clone(details: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _updateInvoice(UpdateInvoice event, Emitter<InvoiceListState> emit) async {
    InvoiceData? data = await goToPage(Routes.CREATE_INVOICE,arguments: state.transfers!.response!.invoices!.data![event.index]);
    if(data != null){
      state.transfers!.response!.invoices!.data![event.index] = data;
      emit(state.clone());
    }
  }
}
