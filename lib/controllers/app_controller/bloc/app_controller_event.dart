import 'package:flutter/material.dart';

abstract class AppControllerEvent {}

class InitAppEvent extends AppControllerEvent {}
class ChangeLanguage extends AppControllerEvent {
  Locale locale;

  ChangeLanguage(this.locale);
}