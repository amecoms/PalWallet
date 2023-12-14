import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_wallet/module/sign_in/view/code_verify_sheet.dart';
import 'package:genius_wallet/repositories/user_repository.dart';
import 'package:genius_wallet/utils/design_component.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_constant.dart';

import '../../../Widgets/default_dialog.dart';
import '../../../config/dependency.dart';
import '../../../controllers/share_helper.dart';
import '../../../data/auth.dart';
import '../../../utils/url.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  var arguments;
  AuthRepository repository = AuthRepository();
  UserRepository userRepository = UserRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController code = TextEditingController();
  CountdownController countdownController =  CountdownController(autoStart: true);



  SignInBloc() : super(SignInState().init()) {
    on<InitEvent>(_init);
    on<RememberMe>(_changeRemember);
    on<SubmitData>(_submitData);
    on<SendTwoFaCode>(_sendCode);
    on<VerifyCode>(_twoFaVerification);
  }

  @override
  Future<void> close() {
    countdownController.pause();
    repository.close();
    userRepository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SignInState> emit) async {
    if (kDebugMode) {
      email.text = 'user@gmail.com';
      password.text = '123456';
    }
    arguments = settings(event.context).arguments;

    emit(state.clone());
  }

  Future _changeRemember(RememberMe event, Emitter<SignInState> emit) async {
    emit(state.clone(rememberMe: event.value));
  }

  Future _submitData(SubmitData event, Emitter<SignInState> emit) async {
    if(!formKey.currentState!.validate()) return;
    emit(state.clone(state: PageState.Loading));
    await repository.postSignIn(
      body: <String,dynamic>{
        AppConstant.email: email.text,
        AppConstant.password: password.text,
      },
      onSuccess: (data) {
        instance.registerSingleton<Auth>(data);
        emit(state.clone(auth: data));
        if(data.response!.user!.twoFaStatus == "1"){
          verifyDialog();
        } else {
          ShareHelper.setAuth(data);
          goAndRemoveAllPages(Routes.MAIN_PAGE);
        }
      },
      onError: (data) {
      },
    );
    emit(state.clone(state: PageState.Success));
  }


  FutureOr<void> _twoFaVerification(VerifyCode event, Emitter<SignInState> emit) async {
    emit(state.clone(verificationLoading: true));
    await userRepository.changeTwoFaState(
        url: URL.loginVerification,
        body: {
          AppConstant.code: code.text,
        },
        onSuccess: (data){
          ShareHelper.setAuth(state.auth!);
          backPage();
          goAndRemoveAllPages(Routes.MAIN_PAGE);
        },
        onError: (data){}
    );
    emit(state.clone(verificationLoading: false));
  }

  void verifyDialog(){
    DesignComponent.showBottomSheetPopup(
      isScrollControlled: true,
      child: CodeVerifySheet(this)
    );
  }

  FutureOr<void> _sendCode(SendTwoFaCode event, Emitter<SignInState> emit) async {
    emit(state.clone(state: PageState.Loading));
    await userRepository.sendTwoFaCode(
        body: {},
        isResend: true,
        onSuccess: (data){
          countdownController.restart();
        },
        onError: (data){
        }
    );
    emit(state.clone(state: PageState.Success));
  }
}
