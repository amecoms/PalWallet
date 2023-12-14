import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppColor{
  static const Color primary= Color(0xFFe65525);
  static Color? logoColor;
  static Color primary2= const Color(0xFFF7ECDF);
  static Color primaryLite= const Color(0xFFECEDF1);
  static Color cardColor=Colors.white;
  static Color cardShadow=const Color(0xFF858585).withOpacity(0.2);
  static Color shadowColor=const Color(0xFFA2A2A2);
  static Color background= const Color(0xFFFAFAFA);
  static Color white= const Color(0xFFFFFFFF);
  static Color textColor= const Color(0xFF19110E);
  static Color textColor3= const Color(0xFF757882);
  static Color textColor2= const Color(0xFFA3A5AC);
  static Color iconColor= const Color(0xFF292D32);
  static Color buttonDisableColor=const Color(0xFFEFEFEF);
  static Color appBarColor=Colors.white;
  static Color buttonTextColor=Colors.white;
  static Color grey= const Color(0xFF9C9CA6);
  static Color dividerColor= const Color(0xFFD1D2D5);
  static Color textFieldBackground= const Color(0xFFF5F5F5);
  static Color green= const Color(0xFF009247);
  static Color yellow= const Color(0xFFFFB950);
  static Color red= const Color(0xFFFE443A);


  static getColorFromColorCode(String code){
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  static getColorCodeFromColor(Color color){
    return '#${color.value.toRadixString(16)}';
  }

  static Color getGenerateColor(){
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  static void applyDark(){
    background = const Color(0xFFF72C0A);
    cardColor = const Color(0xFFf70000);
    appBarColor = const Color(0xFFf70000);
    logoColor = const Color(0xFFFFF4E7);
    textColor = const Color(0xFFFFF4E7);
    iconColor = const Color(0xFFFFF4E7);
    grey = const Color(0xFF626976);
    textFieldBackground = const Color(0xFFF72C0A);
    dividerColor = const Color(0xFFe64025);
  }

  static void applyLight(){
    background= const Color(0xFFFAFAFA);
    cardColor=Colors.white;
    appBarColor=Colors.white;
    logoColor = null;
    textColor= const Color(0xFF19110E);
    iconColor= const Color(0xFFf76707);
    grey= const Color(0xFF9C9CA6);
    textFieldBackground= const Color(0xFFF5F5F5);
    dividerColor= const Color(0xFFE6E7E9);
  }
}