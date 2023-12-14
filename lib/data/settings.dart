import '../config/dependency.dart';

class Settings {
  Settings({
      this.success, 
      this.message, 
      this.response,});

  Settings.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  bool? success;
  String? message;
  Response? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }
  static Settings? getSettings(){
    try{
      return instance.get<Settings>();
    } catch(e){
      return null;
    }
  }

}

class Response {
  Response({
      this.logo, 
      this.title, 
      this.isMaintenance, 
      this.twoFa,});

  Response.fromJson(dynamic json) {
    logo = json['logo'];
    title = json['title'];
    isMaintenance = json['is_maintenance'];
    twoFa = json['two_fa'];
  }
  String? logo;
  String? title;
  String? isMaintenance;
  String? twoFa;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = logo;
    map['title'] = title;
    map['is_maintenance'] = isMaintenance;
    map['two_fa'] = twoFa;
    return map;
  }

}