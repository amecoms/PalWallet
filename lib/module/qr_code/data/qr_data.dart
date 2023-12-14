class QrData {
  QrData({
      this.success, 
      this.message, 
      this.response,});

  QrData.fromJson(dynamic json) {
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
      this.qrcodeImage,});

  Response.fromJson(dynamic json) {
    qrcodeImage = json['qrcode_image'];
  }
  String? qrcodeImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['qrcode_image'] = qrcodeImage;
    return map;
  }

}