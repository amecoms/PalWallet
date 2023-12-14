import 'package:flutter/src/widgets/framework.dart';

abstract class SignInEvent {}

class InitEvent extends SignInEvent {
  BuildContext context;
  InitEvent(this.context);
}

class RememberMe extends SignInEvent {
  bool value;
  RememberMe(this.value);
}

class SendTwoFaCode extends SignInEvent {}
class VerifyCode extends SignInEvent {}
class SubmitData extends SignInEvent {}
class TwoFaVerification extends SignInEvent {
  String code;

  TwoFaVerification(this.code);
}