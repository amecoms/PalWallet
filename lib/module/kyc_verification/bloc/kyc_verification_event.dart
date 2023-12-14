import 'package:flutter/material.dart';

abstract class KycVerificationEvent {}

class InitEvent extends KycVerificationEvent {
  BuildContext context;

  InitEvent(this.context);
}

class AddFile extends KycVerificationEvent {
  dynamic image;
  int index;
  AddFile(this.image, this.index);
}

class GetForm extends KycVerificationEvent{}
class SubmitLoanRequest extends KycVerificationEvent{}