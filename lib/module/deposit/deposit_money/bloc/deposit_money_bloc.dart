import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/routes/app_pages.dart';

import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../repositories/deposit_repository.dart';
import '../../../../utils/app_constant.dart';
import 'deposit_money_event.dart';
import 'deposit_money_state.dart';
import 'package:flutter/material.dart';

class DepositMoneyBloc extends Bloc<DepositMoneyEvent, DepositMoneyState> {
  DepositRepository repository = DepositRepository();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  DepositMoneyBloc() : super(DepositMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitData);
    on<ChangeWallets>(_changeWallets);
    on<ChangeMethod>(_changeMethod);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<DepositMoneyState> emit) async {
    await repository.getDepositFrom(
      onSuccess: (data){
        emit(state.clone(moneyFrom: data));
      },
      onError: (data){}
    );
  }


  FutureOr<void> _submitData(SubmitTransfer event, Emitter<DepositMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
    if(state.selectedGateway == null) return;

    emit(state.clone(pageState: PageState.Loading));
    await repository.submitDeposit(
      body: {
        'gateway_id': state.selectedGateway!.id.toString(),
        'curr_code': state.selectedWallets!.code!,
        'amount':amount.text,
      },
      onSuccess: (data){
        Map<String, dynamic> response = data['response'];
        if(response.containsKey('browser') && (response['browser'] ?? false)){
          backPage();
          Helper.goBrowser(response['webview_url']);
        } else {
          goAndReplacePage(Routes.PAYMENT_PAGE, arguments: {
            AppConstant.url: response['webview_url']
          });
        }
      },
      onError: (data){}
    );
    emit(state.clone(pageState: PageState.Success));
  }

  FutureOr<void> _changeWallets(ChangeWallets event, Emitter<DepositMoneyState> emit) async {
    state.gateways = null;
    state.selectedGateway = null;
    emit(state.clone(selectedWallets: event.wallets));
    await repository.getDepositGateways(
      currency: event.wallets!.id.toString(),
      onSuccess: (data){
        emit(state.clone(gateways: data));
      },
      onError: (data){}
    );
  }

  FutureOr<void> _changeMethod(ChangeMethod event, Emitter<DepositMoneyState> emit) {
    emit(state.clone(selectedGateway: event.methods));
  }
}
