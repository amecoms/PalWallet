import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/utils/design_component.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../view/transfer_confirmation_sheet.dart';
import 'transfer_money_event.dart';
import 'transfer_money_state.dart';
import 'package:flutter/material.dart';

class TransferMoneyBloc extends Bloc<TransferMoneyEvent, TransferMoneyState> {
  TransferRepository repository = TransferRepository();
  TextEditingController receiverEmail = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  DeBouncer debouncer = DeBouncer();

  TransferMoneyBloc() : super(TransferMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TransferMoneyState> emit) async {
    receiverEmail.addListener(() {
      debouncer.run(() {
        searchData();
      });
    });
    getList();
    await repository.getTransferMoneyFrom(
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

  Future getList() async {
    await repository.getTransferList(
      onSuccess: (data){
        emit(state.clone(transferLog: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _submitData(SubmitTransfer event, Emitter<TransferMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.receiverCheck == null) return;
    Helper.hideKeyboard();
    double charge = (state.moneyFrom!.response!.charge!.fixedCharge!.toDouble * state.selectedWallets!.currency!.rate!.toDouble) + (amount.text.toDouble / 100) * state.moneyFrom!.response!.charge!.percentCharge!.toDouble;
    bool? status = await DesignComponent.showBottomSheetPopup(
      isScrollControlled: true,
      child: TransferConfirmationSheet(
        amount.text.toDouble,
        charge,
        state.selectedWallets!.currency!.code!
      )
    );
    if(status != null && status == true) {
      emit(state.clone(pageState: PageState.Loading));
      await repository.submitTransfer(
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

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<TransferMoneyState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }
}
