class TwoFaCode {
  TwoFaCode({
      this.success, 
      this.message, 
      this.response,});

  TwoFaCode.fromJson(dynamic json) {
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

}

class Response {
  Response({
      this.success, 
      this.code,});

  Response.fromJson(dynamic json) {
    success = json['success'];
    code = json['code'];
  }
  bool? success;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['code'] = code;
    return map;
  }

}