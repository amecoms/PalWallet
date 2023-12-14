import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/repositories/withdraw_repository.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import 'withdraw_money_event.dart';
import 'withdraw_money_state.dart';
import 'package:flutter/material.dart';

class WithdrawMoneyBloc extends Bloc<WithdrawMoneyEvent, WithdrawMoneyState> {
  WithdrawRepository repository = WithdrawRepository();
  TextEditingController amount = TextEditingController();
  TextEditingController accountDetails = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<int> amountText = ValueNotifier(0);

  WithdrawMoneyBloc() : super(WithdrawMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
    on<ChangeMethods>(_selectMethods);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<WithdrawMoneyState> emit) async {
    amount.addListener(() {
      amountText.value = (amount.text.isNotEmpty ? amount.text : '0').toInt;
    });
    await repository.getFrom(
      onSuccess: (data){
        emit(state.clone(moneyFrom: data));
      },
      onError: (data){}
    );
  }


  FutureOr<void> _submitData(SubmitTransfer event, Emitter<WithdrawMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.methods == null) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitTransfer(
      body: {
        'method_id':state.selectedMethods!.id.toString(),
        'wallet_id': state.selectedWallets!.id.toString(),
        'amount':amount.text,
        'user_data':accountDetails.text,
      },
      onSuccess: (data){
        backPage();
        SuccessMessage(message: data['message']);
      },
      onError: (data){}
    );
    emit(state.clone(pageState: PageState.Success));
  }

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<WithdrawMoneyState> emit) async {
    state.selectedMethods = null;
    emit(state.clone(selectedWallets: event.wallets));
    await repository.getMethods(
      currencyId: event.wallets!.currency!.id.toString(),
      onSuccess: (data){
        emit(state.clone(methods: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _selectMethods(ChangeMethods event, Emitter<WithdrawMoneyState> emit) {
    emit(state.clone(selectedMethods: event.methods));
  }
}
