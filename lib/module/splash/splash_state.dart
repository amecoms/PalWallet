import 'dart:async';

import '../../../../data/auth.dart';

class SplashState {
  Timer? timer;
  Auth? auth;

  SplashState({this.auth});

  SplashState init() {
    return SplashState(
      auth: Auth.getAuth()
    );
  }

  SplashState clone({Auth? auth}) {
    return SplashState(
      auth: auth
    );
  }
}
