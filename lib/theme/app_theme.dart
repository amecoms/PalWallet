import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/fonts.gen.dart';
import '../utils/dimension.dart';
import 'app_color.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
      //useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: getMaterialColor(Colors.transparent)
      ),
      primaryColor: AppColor.primaryLite,
      primaryColorDark: AppColor.primary,
      primaryColorLight: AppColor.primaryLite,
      scaffoldBackgroundColor: AppColor.background,
      dividerColor: Colors.transparent,
      canvasColor: Colors.white,
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: AppColor.iconColor
          ),
          titleTextStyle: TextStyle(color: AppColor.white,fontSize: 20.spMin,fontWeight: Dimension.textBold)
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
          color: AppColor.white,
          shadowColor: AppColor.cardShadow,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColor.primary2,
      ),
      iconTheme: IconThemeData(
          color: AppColor.iconColor
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            color: AppColor.textColor,
            fontSize: 16.spMin,
            fontWeight: Dimension.textBold,
            decorationColor: AppColor.textColor
        ),
        headlineMedium: TextStyle(
            color: AppColor.textColor,
            fontSize: 14.spMin,
            fontWeight: Dimension.textBold,
            decorationColor: AppColor.textColor
        ),
        headlineSmall: TextStyle(
            color: AppColor.textColor,
            fontSize: 12.spMin,
            fontWeight: Dimension.textBold,
            decorationColor: AppColor.textColor
        ),
        displaySmall: TextStyle(
            color: AppColor.textColor,
            fontSize: 14.spMin,
            fontWeight: Dimension.textRegular,
            decorationColor: AppColor.textColor
        ),
        titleSmall: TextStyle(
            color: AppColor.textColor,
            fontSize: 14.spMin,
            fontWeight: Dimension.textRegular,
            height: 1.3,
            decorationColor: AppColor.textColor
        ),
        bodyLarge: TextStyle(
            color: AppColor.textColor,
            fontSize: 14.spMin,
            fontWeight: Dimension.textRegular,
            height: 1.3,
            decorationColor: AppColor.textColor
        ),
        bodyMedium: TextStyle(
            color: AppColor.textColor,
            fontSize: 12.spMin,
            fontWeight: Dimension.textRegular,
            decorationColor: AppColor.textColor
        ),
        bodySmall: TextStyle(
            color: AppColor.textColor,
            fontSize: 10.spMin,
            fontWeight: Dimension.textRegular,
            decorationColor: AppColor.textColor
        ),
      ),
      /*pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: RouteTransition(),
            TargetPlatform.android: RouteTransition()
          }
      ),*/
      fontFamily: FontFamily.plexSans
  );
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}