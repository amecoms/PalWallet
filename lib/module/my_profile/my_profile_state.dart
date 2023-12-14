import 'dart:io';

import '../../../../app_helper/enums.dart';
import '../../../../data/auth.dart';

class MyProfileState {
  Auth? auth;
  PageState pageState;
  File? image;


  MyProfileState({this.pageState = PageState.Initial,this.auth, this.image});

  MyProfileState init() {
    return MyProfileState(
      auth: Auth.getAuth()
    );
  }

  MyProfileState clone({PageState? pageState,Auth? auth, File? image}) {
    return MyProfileState(
      pageState: pageState ?? this.pageState,
      auth: auth ?? this.auth,
      image: image ?? this.image
    );
  }
}
