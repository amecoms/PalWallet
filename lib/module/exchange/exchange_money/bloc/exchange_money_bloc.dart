import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../repositories/exchange_repository.dart';
import 'exchange_money_event.dart';
import 'exchange_money_state.dart';
import 'package:flutter/material.dart';

class ExchangeMoneyBloc extends Bloc<ExchangeMoneyEvent, ExchangeMoneyState> {
  ExchangeRepository repository = ExchangeRepository();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<int> amountText = ValueNotifier(0);

  ExchangeMoneyBloc() : super(ExchangeMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
    on<ChangeToWallets>(_changeToWallets);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ExchangeMoneyState> emit) async {
    amount.addListener(() {
      amountText.value = (amount.text.isNotEmpty ? amount.text : '0').toInt;
    });
    await repository.getExchangeData(
      onSuccess: (data){
        emit(state.clone(exchangeData: data));
      },
      onError: (data){}
    );
  }


  FutureOr<void> _submitData(SubmitTransfer event, Emitter<ExchangeMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitExchangeData(
      body: {
        'from_wallet_id': state.selectedWallets!.id.toString(),
        'to_currency_id': state.selectedToWallets!.id.toString(),
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

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<ExchangeMoneyState> emit) {
    emit(state.clone(selectedWallets: event.wallets));
  }

  FutureOr<void> _changeToWallets(ChangeToWallets event, Emitter<ExchangeMoneyState> emit) {
    emit(state.clone(selectedToWallets: event.wallets));
  }
}
