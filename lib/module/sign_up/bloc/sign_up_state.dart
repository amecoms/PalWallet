import '../../../../app_helper/enums.dart';

class SignUpState {
  bool isAgree = true;
  PageState pageState;


  SignUpState({this.isAgree = false,this.pageState = PageState.Initial});

  SignUpState init() {
    return SignUpState();
  }

  SignUpState clone({bool? isAgree,PageState? state}) {
    return SignUpState(
      isAgree: isAgree ?? this.isAgree,
      pageState: state ?? pageState
    );
  }
}
