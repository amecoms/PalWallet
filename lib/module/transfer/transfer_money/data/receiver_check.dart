class ReceiverCheck {
  ReceiverCheck({
      this.success, 
      this.message, 
      this.response,});

  ReceiverCheck.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    response = json['response'] != null ? json['response'].cast<String>() : [];
  }
  bool? success;
  String? message;
  List<String>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['response'] = response;
    return map;
  }

}