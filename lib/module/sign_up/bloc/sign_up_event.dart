
import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class InitEvent extends SignUpEvent {
  BuildContext context;
  InitEvent(this.context);
}

class ChangeAgree extends SignUpEvent {
  bool value;
  ChangeAgree(this.value);
}

class SubmitData extends SignUpEvent {}