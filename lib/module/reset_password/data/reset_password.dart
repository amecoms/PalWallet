class ResetPassword {
  ResetPassword({
      this.status, 
      this.data, 
      this.error,});

  ResetPassword.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ResetData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  ResetData? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ResetData {
  ResetData({
      this.userId, 
      this.resetToken,});

  ResetData.fromJson(dynamic json) {
    userId = json['user_id'];
    resetToken = json['reset_token'];
  }
  num? userId;
  String? resetToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['reset_token'] = resetToken;
    return map;
  }

}