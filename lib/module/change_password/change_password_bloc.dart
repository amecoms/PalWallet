import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Widgets/show_message.dart';
import '../../app_helper/enums.dart';
import '../../main.dart';
import '../../repositories/user_repository.dart';
import '../../utils/app_constant.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  UserRepository repository = UserRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController conNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ChangePasswordBloc() : super(ChangePasswordState().init()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submitData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ChangePasswordState> emit) async {
    emit(state.clone());
  }

  Future _submitData(SubmitEvent event, Emitter<ChangePasswordState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    }
    Map<String,String> body = {
      'old_pass': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': conNewPasswordController.text,
    };
    emit(state.clone(pageState: PageState.Loading));
    await repository.changePassword(
        body: body,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().password_changed_successfully);
        },
        onError: (data){
        }
    );
    emit(state.clone(pageState: PageState.Success));
  }
}
