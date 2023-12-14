import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/merchant_payment_repository.dart';
import '../../../../repositories/transfer_repository.dart';
import 'merchant_payment_event.dart';
import 'merchant_payment_state.dart';
import 'package:flutter/material.dart';

class MerchantPaymentBloc extends Bloc<MerchantPaymentEvent, MerchantPaymentState> {
  MerchantPaymentRepository repository = MerchantPaymentRepository();
  TextEditingController receiverEmail = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  DeBouncer debouncer = DeBouncer();

  MerchantPaymentBloc() : super(MerchantPaymentState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MerchantPaymentState> emit) async {
    receiverEmail.addListener(() {
      debouncer.run(() {
        searchData();
      });
    });
    await repository.getPaymentFrom(
      onSuccess: (data){
        emit(state.clone(moneyFrom: data));
      },
      onError: (data){}
    );
  }
  void searchData() {
    state.receiverCheck = null;
    emit(state.clone());
    if(receiverEmail.text.isNotEmpty && Helper.isEmailValid(receiverEmail.text)){
      state.receiverCheck = null;
      repository.checkMerchant(
        email: receiverEmail.text,
        onSuccess: (data){
          emit(state.clone(receiverCheck: data));
        },
        onError: (data){
          emit(state.clone(receiverCheck: data));
        }
      );
    }
  }


  FutureOr<void> _submitData(SubmitTransfer event, Emitter<MerchantPaymentState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.receiverCheck == null) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitPayment(
      body: {
        'receiver':receiverEmail.text,
        'wallet': state.selectedWallets!.id.toString(),
        'amount':amount.text,
      },
      onSuccess: (data){
        backPage();
        SuccessMessage(message: data['message']);
      },
      onError: (data){}
    );
    emit(state.clone(pageState: PageState.Success));
  }

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<MerchantPaymentState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }
}
