import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Widgets/show_message.dart';
import '../../../controllers/share_helper.dart';
import '../../../data/auth.dart';
import '../../../main.dart';
import '../../../repositories/user_repository.dart';
import 'kyc_verification_event.dart';
import 'kyc_verification_state.dart';

class KycVerificationBloc extends Bloc<KycVerificationEvent, KycVerificationState> {
  UserRepository repository = UserRepository();
  GlobalKey<FormState> formKey = GlobalKey();

  KycVerificationBloc() : super(KycVerificationState().init()) {
    on<InitEvent>(_init);
    on<AddFile>(_addFile);
    on<SubmitLoanRequest>(_submitRequest);
    on<GetForm>(_getForm);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<KycVerificationState> emit) async {
    emit(state.clone());
    add(GetForm());
  }

  FutureOr<void> _addFile(AddFile event, Emitter<KycVerificationState> emit) {
    state.formData!.response!.data![event.index].data = event.image;
    emit(state.clone(formData: state.formData));
  }

  FutureOr<void> _submitRequest(SubmitLoanRequest event, Emitter<KycVerificationState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(loading: true));
    Map<String,String> body ={};
    List<File> files = [];
    List<String> fileKeys = [];
    if(state.formData!=null && state.formData!.response!.data!.isNotEmpty){
      for (var element in state.formData!.response!.data!) {
        if(element.isTextField!){
          body[element.name!]=element.controller!.text;
        } else {
          fileKeys.add(element.name!);
          files.add(element.data!);
        }
      }
    } else {
      return;
    }
    await repository.submitKyc(
        body: body,
        files: files,
        fileKeys: fileKeys,
        onSuccess: (data){
          Auth auth = Auth.getAuth()!;
          auth.response!.user!.kycStatus = '1';
          ShareHelper.setAuth(auth);
          backPage();
          SuccessMessage(message: appLanguage().kyc_submitted_successfully);
        },
        onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(loading: false));
  }

  FutureOr<void> _getForm(GetForm event, Emitter<KycVerificationState> emit) async {
    await repository.getKycForm(
        onSuccess: (data){
          emit(state.clone(formData: data));
        },
        onError: (Map<String,dynamic> data){}
    );
  }
}
