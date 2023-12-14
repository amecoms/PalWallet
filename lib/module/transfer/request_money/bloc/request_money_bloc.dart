import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/design_component.dart';
import '../view/request_money_confirmation_sheet.dart';
import 'request_money_event.dart';
import 'request_money_state.dart';
import 'package:flutter/material.dart';

class RequestMoneyBloc extends Bloc<RequestMoneyEvent, RequestMoneyState> {
  TransferRepository repository = TransferRepository();
  TextEditingController receiverEmail = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  DeBouncer debouncer = DeBouncer();

  RequestMoneyBloc() : super(RequestMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<RequestMoneyState> emit) async {
    receiverEmail.addListener(() {
      debouncer.run(() {
        searchData();
      });
    });
    await repository.getRequestMoneyFrom(
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
      repository.checkReceiver(
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

  FutureOr<void> _submitData(SubmitTransfer event, Emitter<RequestMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.receiverCheck == null) return;
    Helper.hideKeyboard();
    double charge = (state.moneyFrom!.response!.charge!.fixedCharge!.toDouble * state.selectedWallets!.currency!.rate!.toDouble) + (amount.text.toDouble / 100) * state.moneyFrom!.response!.charge!.percentCharge!.toDouble;
    bool? status = await DesignComponent.showBottomSheetPopup(
        isScrollControlled: true,
        child: RequestMoneyConfirmationSheet(
            amount.text.toDouble,
            charge,
            state.selectedWallets!.currency!.code!
        )
    );
    if(status != null && status == true) {
      emit(state.clone(pageState: PageState.Loading));
      await repository.submitRequest(
          body: {
            'receiver': receiverEmail.text,
            'wallet_id': state.selectedWallets!.id.toString(),
            'amount': amount.text,
          },
          onSuccess: (data) {
            backPage();
            SuccessMessage(message: data['message']);
          },
          onError: (data) {}
      );
      emit(state.clone(pageState: PageState.Success));
    }
  }

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<RequestMoneyState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }
}
