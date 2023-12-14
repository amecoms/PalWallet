class RequestList {
  RequestList({
      this.success, 
      this.message, 
      this.response,});

  RequestList.fromJson(dynamic json) {
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
      this.receivedMoneyRequests,});

  Response.fromJson(dynamic json) {
    receivedMoneyRequests = json['received_money_requests'] != null ? ReceivedMoneyRequests.fromJson(json['received_money_requests']) : null;
  }
  ReceivedMoneyRequests? receivedMoneyRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (receivedMoneyRequests != null) {
      map['received_money_requests'] = receivedMoneyRequests?.toJson();
    }
    return map;
  }

}

class ReceivedMoneyRequests {
  ReceivedMoneyRequests({
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

  ReceivedMoneyRequests.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestData.fromJson(v));
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
  List<RequestData>? data;
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

class RequestData {
  RequestData({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.currencyId, 
      this.requestAmount, 
      this.charge, 
      this.finalAmount, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.currency, 
      this.sender,});

  RequestData.fromJson(dynamic json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    currencyId = json['currency_id'];
    requestAmount = json['request_amount'];
    charge = json['charge'];
    finalAmount = json['final_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
  }
  num? id;
  String? senderId;
  String? receiverId;
  String? currencyId;
  String? requestAmount;
  String? charge;
  String? finalAmount;
  String? status;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  Sender? sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['currency_id'] = currencyId;
    map['request_amount'] = requestAmount;
    map['charge'] = charge;
    map['final_amount'] = finalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    return map;
  }

}

class Sender {
  Sender({
      this.id, 
      this.name, 
      this.email, 
      this.photo,});

  Sender.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
  num? id;
  String? name;
  String? email;
  dynamic photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['photo'] = photo;
    return map;
  }

}

class Currency {
  Currency({
      this.id, 
      this.defaultValue,
      this.symbol, 
      this.code, 
      this.currName, 
      this.type, 
      this.status, 
      this.rate, 
      this.createdAt, 
      this.updatedAt,});

  Currency.fromJson(dynamic json) {
    id = json['id'];
    defaultValue = json['default'];
    symbol = json['symbol'];
    code = json['code'];
    currName = json['curr_name'];
    type = json['type'];
    status = json['status'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? defaultValue;
  String? symbol;
  String? code;
  String? currName;
  String? type;
  String? status;
  String? rate;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['default'] = defaultValue;
    map['symbol'] = symbol;
    map['code'] = code;
    map['curr_name'] = currName;
    map['type'] = type;
    map['status'] = status;
    map['rate'] = rate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}