class EscrowList {
  EscrowList({
      this.success, 
      this.message, 
      this.response,});

  EscrowList.fromJson(dynamic json) {
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
      this.escrows,});

  Response.fromJson(dynamic json) {
    escrows = json['escrows'] != null ? Escrows.fromJson(json['escrows']) : null;
  }
  Escrows? escrows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (escrows != null) {
      map['escrows'] = escrows?.toJson();
    }
    return map;
  }

}

class Escrows {
  Escrows({
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

  Escrows.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(EscData.fromJson(v));
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
  List<EscData>? data;
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

class EscData {
  EscData({
      this.id, 
      this.trnx, 
      this.userId, 
      this.recipientId, 
      this.recipientEmail,
      this.description,
      this.amount, 
      this.payCharge, 
      this.charge, 
      this.currencyId, 
      this.status, 
      this.disputeCreated, 
      this.returnedTo, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,
      this.isLoading = false
  });

  EscData.fromJson(dynamic json) {
    id = json['id'];
    trnx = json['trnx'];
    userId = json['user_id'];
    recipientId = json['recipient_id'];
    recipientEmail = json['recipient']['email'];
    description = json['description'];
    amount = json['amount'];
    payCharge = json['pay_charge'];
    charge = json['charge'];
    currencyId = json['currency_id'];
    status = json['status'];
    disputeCreated = json['dispute_created'];
    returnedTo = json['returned_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    isLoading = false;
  }
  num? id;
  String? trnx;
  String? userId;
  String? recipientId;
  String? recipientEmail;
  String? description;
  String? amount;
  String? payCharge;
  String? charge;
  String? currencyId;
  String? status;
  dynamic disputeCreated;
  dynamic returnedTo;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  late bool isLoading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trnx'] = trnx;
    map['user_id'] = userId;
    map['recipient_id'] = recipientId;
    map['description'] = description;
    map['amount'] = amount;
    map['pay_charge'] = payCharge;
    map['charge'] = charge;
    map['currency_id'] = currencyId;
    map['status'] = status;
    map['dispute_created'] = disputeCreated;
    map['returned_to'] = returnedTo;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
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