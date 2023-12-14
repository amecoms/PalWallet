abstract class TwoFAVerificationEvent {}

class InitEvent extends TwoFAVerificationEvent {}

class ChangeTwoFaState extends TwoFAVerificationEvent {}
class SendTwoFaCode extends TwoFAVerificationEvent {
  bool isResend;

  SendTwoFaCode({this.isResend = false});
}