class Tickets {
  Tickets({
      this.success, 
      this.message, 
      this.response,});

  Tickets.fromJson(dynamic json) {
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
      this.tickets,});

  Response.fromJson(dynamic json) {
    tickets = json['tickets'] != null ? TicketData.fromJson(json['tickets']) : null;
  }
  TicketData? tickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tickets != null) {
      map['tickets'] = tickets?.toJson();
    }
    return map;
  }

}

class TicketData {
  TicketData({
      this.currentPage, 
      this.data, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl, 
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total,});

  TicketData.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SingleTicket.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  num? currentPage;
  List<SingleTicket>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

class SingleTicket {
  SingleTicket({
      this.id, 
      this.userId, 
      this.userType, 
      this.guestEmail, 
      this.guestName, 
      this.ticketNum, 
      this.subject, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  SingleTicket.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    guestEmail = json['guest_email'];
    guestName = json['guest_name'];
    ticketNum = json['ticket_num'];
    subject = json['subject'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userId;
  String? userType;
  dynamic guestEmail;
  dynamic guestName;
  String? ticketNum;
  String? subject;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_type'] = userType;
    map['guest_email'] = guestEmail;
    map['guest_name'] = guestName;
    map['ticket_num'] = ticketNum;
    map['subject'] = subject;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}