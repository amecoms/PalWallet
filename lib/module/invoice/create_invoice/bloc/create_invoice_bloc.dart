import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/module/invoice/invoice_list/data/invoice_history.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/invoice_repository.dart';
import '../data/invoice_currency.dart';
import 'create_invoice_event.dart';
import 'create_invoice_state.dart';
import 'package:flutter/material.dart';

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceState> {
  InvoiceRepository repository = InvoiceRepository();
  TextEditingController invoiceTo = TextEditingController();
  TextEditingController recipientEmail = TextEditingController();
  TextEditingController address = TextEditingController();
  List<TextEditingController> itemNames = [TextEditingController()];
  List<TextEditingController> itemAmounts = [TextEditingController()];
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<double> totalAmount = ValueNotifier(0);

  CreateInvoiceBloc() : super(CreateInvoiceState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
    on<ChangeItems>(_changeItems);
    on<SendEmail>(_sendEmail);
    on<CancelInvoice>(_cancelInvoice);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<CreateInvoiceState> emit) async {
    itemAmounts[0].addListener(amountListener);
    InvoiceData? data = settings(event.context).arguments != null ? settings(event.context).arguments as InvoiceData : null;
    if(data != null) {
      await repository.invoiceDetails(
        invoiceNumber: data.number!,
        onSuccess: (invoice){
          emit(state.clone(invoiceData: data, isEdit: true, invoiceDetails: invoice));
        },
        onError: (data){}
      );
    }
    await repository.getInvoiceFrom(
      onSuccess: (data){
        if(state.invoiceDetails != null){
          Currencies? selectedWallets = data.response!.currencies!.where((element) => element.id == state.invoiceData!.currency!.id).first;
          itemNames[0].text = state.invoiceDetails!.response!.invoiceItems![0].name ?? '';
          itemAmounts[0].text = (state.invoiceDetails!.response!.invoiceItems![0].amount ?? '0').toDouble.toStringAsFixed(0);
          if(state.invoiceDetails!.response!.invoiceItems!.length > 1){
            for(int i=1; i< state.invoiceDetails!.response!.invoiceItems!.length; i++){
              itemNames.add(TextEditingController(text: state.invoiceDetails!.response!.invoiceItems![i].name ?? ''));
              itemAmounts.add(TextEditingController(text: (state.invoiceDetails!.response!.invoiceItems![0].amount ?? '0').toDouble.toStringAsFixed(0)));
            }
          }
          invoiceTo.text = state.invoiceDetails!.response!.invoice!.invoiceTo ?? '';
          recipientEmail.text = state.invoiceDetails!.response!.invoice!.email ?? '';
          address.text = state.invoiceDetails!.response!.invoice!.address ?? '';
          emit(state.clone(moneyFrom: data, selectedWallets: selectedWallets));
        } else {
          emit(state.clone(moneyFrom: data));
        }

      },
      onError: (data){}
    );
  }

  void amountListener(){
    double amount = 0;
    for (var element in itemAmounts) {
      amount += (element.text.isNotEmpty ? element.text : '0').toDouble;
    }
    totalAmount.value = amount;
  }


  FutureOr<void> _submitData(SubmitTransfer event, Emitter<CreateInvoiceState> emit) async {
    if(!formKey.currentState!.validate()) return;
    Map<String, String> body = {
      'invoice_to': invoiceTo.text,
      'email': recipientEmail.text,
      'address': address.text,
      'currency_id': state.selectedWallets!.id.toString(),
    };
    for(int i=0; i<itemNames.length; i++){
      body['item[$i]']=itemNames[i].text;
      body['amount[$i]']=itemAmounts[i].text;
    }

    emit(state.clone(pageState: PageState.Loading));
    if(state.isEdit){
      await repository.updateInvoice(
        invoiceId: state.invoiceData!.id.toString(),
        body: body,
        onSuccess: (data){
          state.invoiceData!.invoiceTo = invoiceTo.text;
          state.invoiceData!.email = recipientEmail.text;
          state.invoiceData!.address = address.text;
          state.invoiceData!.currency = Currency.fromJson(state.selectedWallets!.toJson());
          backPage(state.invoiceData);
          SuccessMessage(message: data['message']);
        },
        onError: (data){}
      );
    } else {
      await repository.submitInvoice(
        body: body,
        onSuccess: (data) {
          backPage();
          SuccessMessage(message: data['message']);
        },
        onError: (data) {}
      );
    }
    emit(state.clone(pageState: PageState.Success));
  }

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<CreateInvoiceState> emit) async {
    emit(state.clone(selectedWallets: event.wallets));
  }


  FutureOr<void> _changeItems(ChangeItems event, Emitter<CreateInvoiceState> emit) {
    if(event.removeIndex != null){
      itemAmounts.removeAt(event.removeIndex!);
      itemNames.removeAt(event.removeIndex!);
    } else {
      itemNames.add(TextEditingController());
      TextEditingController amount = TextEditingController();
      amount.addListener(amountListener);
      itemAmounts.add(amount);
    }
    amountListener();
    emit(state.clone());
  }

  FutureOr<void> _sendEmail(SendEmail event, Emitter<CreateInvoiceState> emit) async {
    emit(state.clone(sendEmailState: PageState.Loading));
    await repository.sendEmail(
      invoiceId: state.invoiceData!.id.toString(),
      onSuccess: (data){
        SuccessMessage(message: data['message']);
      },
      onError: (data){}
    );
    emit(state.clone(sendEmailState: PageState.Success));
  }

  FutureOr<void> _cancelInvoice(CancelInvoice event, Emitter<CreateInvoiceState> emit) async {
    emit(state.clone(cancelInvoiceState: PageState.Loading));
    await repository.cancelInvoice(
        invoiceId: state.invoiceData!.id.toString(),
        onSuccess: (data){
          state.invoiceData!.status = '2';
          backPage(state.invoiceData);
          SuccessMessage(message: data['message']);
        },
        onError: (data){}
    );
    emit(state.clone(cancelInvoiceState: PageState.Success));
  }
}
