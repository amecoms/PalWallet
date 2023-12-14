class InvoiceHistory {
  InvoiceHistory({
      this.success, 
      this.message, 
      this.response,});

  InvoiceHistory.fromJson(dynamic json) {
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
      this.invoices,});

  Response.fromJson(dynamic json) {
    invoices = json['invoices'] != null ? Invoices.fromJson(json['invoices']) : null;
  }
  Invoices? invoices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (invoices != null) {
      map['invoices'] = invoices?.toJson();
    }
    return map;
  }

}

class Invoices {
  Invoices({
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

  Invoices.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InvoiceData.fromJson(v));
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
  List<InvoiceData>? data;
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

class InvoiceData {
  InvoiceData({
      this.id, 
      this.userId, 
      this.number, 
      this.currencyId, 
      this.invoiceTo, 
      this.email, 
      this.address, 
      this.charge, 
      this.finalAmount, 
      this.getAmount, 
      this.paymentStatus, 
      this.status, 
      this.createdAt, 
      this.currency,
      this.updatedAt,});

  InvoiceData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    number = json['number'];
    currencyId = json['currency_id'];
    invoiceTo = json['invoice_to'];
    email = json['email'];
    address = json['address'];
    charge = json['charge'];
    finalAmount = json['final_amount'];
    getAmount = json['get_amount'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? userId;
  String? number;
  String? currencyId;
  String? invoiceTo;
  String? email;
  String? address;
  String? charge;
  String? finalAmount;
  String? getAmount;
  String? paymentStatus;
  String? status;
  Currency? currency;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['number'] = number;
    map['currency_id'] = currencyId;
    map['invoice_to'] = invoiceTo;
    map['email'] = email;
    map['address'] = address;
    map['charge'] = charge;
    map['final_amount'] = finalAmount;
    map['get_amount'] = getAmount;
    map['payment_status'] = paymentStatus;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['currency'] = currency?.toJson();
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