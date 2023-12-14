import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/voucher_repository.dart';
import 'create_voucher_event.dart';
import 'create_voucher_state.dart';
import 'package:flutter/material.dart';

class CreateVoucherBloc extends Bloc<CreateVoucherEvent, CreateVoucherState> {
  VoucherRepository repository = VoucherRepository();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  CreateVoucherBloc() : super(CreateVoucherState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<CreateVoucherState> emit) async {
    await repository.getVoucherData(
      onSuccess: (data){
        emit(state.clone(voucherData: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _submitData(SubmitTransfer event, Emitter<CreateVoucherState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitVoucherData(
      body: {
        'wallet_id': state.selectedWallets!.id.toString(),
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

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<CreateVoucherState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }
}
