import '../../../../app_helper/enums.dart';

import '../../../data/auth.dart';

class SignInState {
  bool rememberMe = true;
  PageState pageState;
  bool verificationLoading = false;
  Auth? auth;


  SignInState({this.rememberMe = true,this.pageState = PageState.Initial, this.verificationLoading = false, this.auth});

  SignInState init() {
    return SignInState();
  }

  SignInState clone({bool? rememberMe,PageState? state, bool? verificationLoading, Auth? auth}) {
    return SignInState(
      rememberMe: rememberMe ?? this.rememberMe,
      pageState: state ?? pageState,
      verificationLoading: verificationLoading ?? this.verificationLoading,
      auth: auth ?? this.auth
    );
  }
}
