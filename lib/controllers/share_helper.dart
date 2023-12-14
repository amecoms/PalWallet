import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/config/dependency.dart';
import 'package:genius_wallet/controllers/app_controller/data/languages.dart';
import 'package:genius_wallet/data/auth.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user.dart';


class ShareHelper{
  static SharedPreferences? preferences;
  static Future init() async{
    await SharedPreferences.getInstance().then((pr) {
      preferences = pr;
      getAuth();
    });
  }


  static String getLanguage() {
    String? currentLanguageCode = preferences!.getString(AppConstant.Share_Language);
    if(currentLanguageCode == null) {
      String deviceLanguage = Platform.localeName.split('_')[0];
      log("Device language code = $deviceLanguage");
      List<Languages> matchesLanguage = Languages.languages.where((element) => element.locale.languageCode == deviceLanguage).toList();
      if(matchesLanguage.isNotEmpty){
        currentLanguageCode = matchesLanguage[0].locale.languageCode;
      } else {
        currentLanguageCode = 'en';
      }
      setLanguage(currentLanguageCode);
    }
    log("Current language code = $currentLanguageCode");
    return currentLanguageCode;
  }

  static void setLanguage(String key) {
    preferences!.setString(AppConstant.Share_Language,key);
  }


  static void setAuth(Auth user) {
    instance.registerSingleton<Auth>(user);
    preferences!.setString(AppConstant.Share_Auth, jsonEncode(user.toJson()));
  }

  static Auth? getAuth() {
    //preferences!.remove(AppConstant.Share_User);
    if(!preferences!.containsKey(AppConstant.Share_Auth)) return null;

    Auth auth = Auth.fromJson(jsonDecode(preferences!.getString(AppConstant.Share_Auth)!));
    instance.registerSingleton<Auth>(auth);
    return auth;
  }





  ShareHelper.logOut({bool forceLogout = true}){
    try{
      instance.unregister<Auth>();
    }catch(e){}
    preferences!.remove(AppConstant.Share_Auth);
    if(forceLogout){
      goAndRemoveAllPages(Routes.SIGN_IN);
    }
  }

}
