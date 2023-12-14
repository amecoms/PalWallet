import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/repositories/user_repository.dart';

import '../../../controllers/share_helper.dart';
import '../../../data/auth.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/design_component.dart';
import '../../../utils/url.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../view/code_verify_sheet.dart';
import 'two_fa_verification_event.dart';
import 'two_fa_verification_state.dart';

class TwoFAVerificationBloc extends Bloc<TwoFAVerificationEvent, TwoFAVerificationState> {
  UserRepository repository = UserRepository();
  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  TextEditingController code = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  CountdownController countdownController =  CountdownController(autoStart: true);

  TwoFAVerificationBloc() : super(TwoFAVerificationState().init()) {
    on<InitEvent>(_init);
    on<ChangeTwoFaState>(_changeTwoFaState);
    on<SendTwoFaCode>(_sendTwoFaCode);
  }

  @override
  Future<void> close() {
    countdownController.pause();
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TwoFAVerificationState> emit) async {
  }

  FutureOr<void> _changeTwoFaState(ChangeTwoFaState event, Emitter<TwoFAVerificationState> emit) async {
    emit(state.clone(verificationLoading: true));
    await repository.changeTwoFaState(
      url: URL.enableVerification,
      body: {
        AppConstant.code: code.text,
      },
      onSuccess: (data){
        state.user.twoFaStatus = state.user.twoFaStatus! == "1" ? "0" : "1";
        emit(state);
        Auth? auth = Auth.getAuth();
        auth!.response!.user = state.user;
        ShareHelper.setAuth(auth);
        backPage();
        backPage();
        SuccessMessage(message: data['message']);
      },
      onError: (data){}
    );
    emit(state.clone(verificationLoading: false));
  }

  FutureOr<void> _sendTwoFaCode(SendTwoFaCode event, Emitter<TwoFAVerificationState> emit) async {
    if(!formKey.currentState!.validate()) return;
    emit(state.clone(pageState: PageState.Loading));
    await repository.sendTwoFaCode(
      body: {
        'password': password.text,
        'password_confirmation': conPassword.text,
      },
      isResend: event.isResend,
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,faData: data));
        if(!event.isResend) {
          verifyDialog();
        } else {
          countdownController.restart();
        }
      },
      onError: (data){
        emit(state.clone(pageState: PageState.Error));
      }
    );
    emit(state.clone(pageState: PageState.Success));
  }

  void verifyDialog(){
    DesignComponent.showBottomSheetPopup(
      isScrollControlled: true,
      child: CodeVerifySheet(this)
    );
  }
}
