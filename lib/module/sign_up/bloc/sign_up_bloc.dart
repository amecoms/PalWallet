import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_constant.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository repository = AuthRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  PhoneController phoneController = PhoneController(AppConstant.defaultPhoneNumber);



  SignUpBloc() : super(SignUpState().init()) {
    on<InitEvent>(_init);
    on<ChangeAgree>(_changeAgree);
    on<SubmitData>(_submitData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SignUpState> emit) async {
    emit(state.clone());
  }

  Future _changeAgree(ChangeAgree event, Emitter<SignUpState> emit) async {
    emit(state.clone(isAgree: event.value));
  }

  Future _submitData(SubmitData event, Emitter<SignUpState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    } else if(!phoneController.value!.isValid()) {
      ErrorMessage(message: appLanguage().please_enter_valid_phone_number);
      return;
    } else if(!state.isAgree){
      ErrorMessage(message: appLanguage().please_agree_with_terms_add_policy);
      return;
    }
    emit(state.clone(state: PageState.Loading));
    await repository.postSignUp(
      body: <String,dynamic>{
        AppConstant.name: name.text,
        AppConstant.email: email.text,
        AppConstant.dial_code: phoneController.value!.countryCode,
        AppConstant.phone: phoneController.value!.nsn,
        AppConstant.password: password.text,
        AppConstant.password_confirmation: password.text,
        AppConstant.address: address.text,
        AppConstant.country: country.text,
      },
      onSuccess: (data) {
        goAndRemoveAllPages(Routes.MAIN_PAGE);
      },
      onError: (data) {
      },
    );
    emit(state.clone(state: PageState.Success));
  }
}
