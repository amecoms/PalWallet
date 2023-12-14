
import 'package:genius_wallet/data/user.dart';

import '../config/dependency.dart';
import '../main.dart';

class Auth {
  Auth({
    this.success,
    this.message,
    this.response,});

  Auth.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    response = json['response'] != null ? AuthData.fromJson(json['response']) : null;
  }
  bool? success;
  String? message;
  AuthData? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

  static Auth? getAuth(){
    try{
      return instance.get<Auth>();
    } catch(e){
      return null;
    }
  }

}

class AuthData {
  AuthData({
      this.token, 
      this.user,});

  AuthData.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}