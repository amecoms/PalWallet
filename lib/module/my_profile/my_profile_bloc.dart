
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/get_image.dart';
import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/enums.dart';
import '../../../../data/auth.dart';
import '../../../../main.dart';
import '../../../../repositories/user_repository.dart';
import '../../../../utils/app_constant.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../utils/dimension.dart';
import 'my_profile_event.dart';
import 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  UserRepository repository = UserRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fax = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();

  PhoneController phoneController = PhoneController(AppConstant.defaultPhoneNumber);
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> imagePlace = ValueNotifier(false);

  MyProfileBloc() : super(MyProfileState().init()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submitData);
    on<ChangeImage>(_changeImage);
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MyProfileState> emit) async {
    scrollController.addListener(() {
      imagePlace.value = _horizontalTitlePadding;
    });
    name.text = state.auth!.response!.user!.name ?? '';
    email.text = state.auth!.response!.user!.email ?? '';
    //fax.text = state.auth!.response!.user!.fax ?? '';
    zipCode.text = state.auth!.response!.user!.zip ?? '';
    city.text = state.auth!.response!.user!.city ?? '';
    country.text = state.auth!.response!.user!.country ?? '';
    address.text = state.auth!.response!.user!.address ?? '';
    try {
      phoneController.value = PhoneNumber.parse(state.auth!.response!.user!.phone ?? '');
    } catch(e){}
    emit(state.clone());
  }

  bool get _horizontalTitlePadding {
    double kCollapsedPadding = Dimension.appbarHeight;
    if (scrollController.hasClients) {
      return ((280 - Dimension.appbarHeight).h - kCollapsedPadding) - scrollController.offset <= 0;
    }
    return false;
  }

  Future _submitData(SubmitEvent event, Emitter<MyProfileState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    } else if(!phoneController.value!.isValid()) {
      ErrorMessage(message: appLanguage().please_enter_valid_phone_number);
      return;
    }
    Map<String,String> body = {
      AppConstant.name: name.text,
      AppConstant.email: email.text,
      AppConstant.phone: phoneController.value!.international,
      //AppConstant.fax: fax.text,
      AppConstant.zip: zipCode.text,
      AppConstant.city: city.text,
      AppConstant.country: country.text,
      AppConstant.address: address.text,
    };

    emit(state.clone(pageState: PageState.Loading));
    await repository.updateProfile(
      body: body,
      files: state.image != null ? [state.image!] : [],
      fileKey: state.image != null ? ['photo'] : [],
      onSuccess: (Auth data){
        state.auth = data;
        backPage();
        SuccessMessage(message: appLanguage().profile_updated_successfully);
      },
      onError: (data){
        emit(state.clone(pageState: PageState.Error));
      }
    );
    emit(state.clone(pageState: PageState.Success));
  }

  FutureOr<void> _changeImage(ChangeImage event, Emitter<MyProfileState> emit) async {
    File? image = await getImage();
    if(image != null){
      emit(state.clone(image: image));
    }
  }
}
