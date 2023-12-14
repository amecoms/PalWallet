class SupportMessages {
  SupportMessages({
      this.success, 
      this.message, 
      this.response,});

  SupportMessages.fromJson(dynamic json) {
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
      this.messages,});

  Response.fromJson(dynamic json) {
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Messages {
  Messages({
      this.id, 
      this.ticketId, 
      this.ticketNum, 
      this.userId, 
      this.userType, 
      this.adminId, 
      this.message, 
      this.file, 
      this.createdAt, 
      this.updatedAt,});

  Messages.fromJson(dynamic json) {
    id = json['id'];
    ticketId = json['ticket_id'].toString();
    ticketNum = json['ticket_num'];
    userId = json['user_id'].toString();
    userType = json['user_type'].toString();
    adminId = json['admin_id'];
    message = json['message'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? ticketId;
  String? ticketNum;
  String? userId;
  String? userType;
  dynamic adminId;
  String? message;
  dynamic file;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['ticket_id'] = ticketId;
    map['ticket_num'] = ticketNum;
    map['user_id'] = userId;
    map['user_type'] = userType;
    map['admin_id'] = adminId;
    map['message'] = message;
    map['file'] = file;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}