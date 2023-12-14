import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/voucher_repository.dart';
import 'reedem_voucher_event.dart';
import 'reedem_voucher_state.dart';
import 'package:flutter/material.dart';

class ReedemVoucherBloc extends Bloc<ReedemVoucherEvent, ReedemVoucherState> {
  VoucherRepository repository = VoucherRepository();
  TextEditingController code = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  ReedemVoucherBloc() : super(ReedemVoucherState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ReedemVoucherState> emit) async {
    await repository.getVoucherReedemData(
      onSuccess: (data){
        emit(state.clone(voucherData: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _submitData(SubmitTransfer event, Emitter<ReedemVoucherState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitRedeemVoucherData(
      body: {
        'code':code.text,
      },
      onSuccess: (data){
        backPage();
        SuccessMessage(message: data['message']);
      },
      onError: (data){}
    );
    emit(state.clone(pageState: PageState.Success));
  }

}
