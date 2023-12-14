import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class InitEvent extends SettingsEvent {
  BuildContext context;
  InitEvent(this.context);
}