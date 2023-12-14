import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genius_wallet/controllers/share_helper.dart';

import '../../../theme/app_color.dart';

class AppControllerState {
  Locale locale = const Locale('en');

  AppControllerState({this.locale=const Locale('en')});

  Iterable<Locale> supportedLocales = [const Locale('en'), const Locale('sv')];

  Locale? localeResolutionCallBack(List<Locale>? locales, Iterable<Locale> supportedLocale) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locales?.first.languageCode &&
          supportedLocale.countryCode == locales?.first.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocale.first;
  }

  Future<AppControllerState> inti() async{
    locale = Locale(ShareHelper.getLanguage());
    return this;
  }

  AppControllerState copyWith({Locale? locale,bool changeTheme = false}) {
    if(locale!=null){
      ShareHelper.setLanguage(locale.languageCode);
    }
    return AppControllerState(
        locale: locale ?? this.locale
    );
  }
}
