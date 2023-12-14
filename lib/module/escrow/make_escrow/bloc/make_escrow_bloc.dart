import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/repositories/escrow_repository.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import '../../../../utils/design_component.dart';
import '../view/escrow_confirmation_sheet.dart';
import 'make_escrow_event.dart';
import 'make_escrow_state.dart';
import 'package:flutter/material.dart';

class MakeEscrowBloc extends Bloc<MakeEscrowEvent, MakeEscrowState> {
  TransferRepository repository = TransferRepository();
  EscrowRepository escrowRepository = EscrowRepository();
  TextEditingController receiverEmail = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<bool> chargePay = ValueNotifier(false);
  DeBouncer debouncer = DeBouncer();

  MakeEscrowBloc() : super(MakeEscrowState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    escrowRepository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MakeEscrowState> emit) async {
    receiverEmail.addListener(() {
      debouncer.run(() {
        searchData();
      });
    });
    await escrowRepository.getEscrowFrom(
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

  FutureOr<void> _submitData(SubmitTransfer event, Emitter<MakeEscrowState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.receiverCheck == null) return;
    Helper.hideKeyboard();
    double charge = (state.moneyFrom!.response!.charge!.fixedCharge!.toDouble * state.selectedWallets!.currency!.rate!.toDouble) + (amount.text.toDouble / 100) * state.moneyFrom!.response!.charge!.percentCharge!.toDouble;
    bool? status = await DesignComponent.showBottomSheetPopup(
        isScrollControlled: true,
        child: EscrowConfirmationSheet(
            amount.text.toDouble,
            charge,
            state.selectedWallets!.currency!.code!
        )
    );
    if(status != null && status == true) {
      emit(state.clone(pageState: PageState.Loading));
      await escrowRepository.submitEscrow(
          body: {
            'receiver': receiverEmail.text,
            'wallet_id': state.selectedWallets!.id.toString(),
            'amount': amount.text,
            'description': description.text,
            'pay_charge': chargePay.value.toString()
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

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<MakeEscrowState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }
}
