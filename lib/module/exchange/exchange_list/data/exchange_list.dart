class ExchangeList {
  ExchangeList({
      this.success, 
      this.message, 
      this.response,});

  ExchangeList.fromJson(dynamic json) {
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
      this.exchanges, 
      this.search,});

  Response.fromJson(dynamic json) {
    exchanges = json['exchanges'] != null ? Exchanges.fromJson(json['exchanges']) : null;
    search = json['search'];
  }
  Exchanges? exchanges;
  dynamic search;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (exchanges != null) {
      map['exchanges'] = exchanges?.toJson();
    }
    map['search'] = search;
    return map;
  }

}

class Exchanges {
  Exchanges({
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

  Exchanges.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ExchangeData.fromJson(v));
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
  List<ExchangeData>? data;
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

class ExchangeData {
  ExchangeData({
      this.id, 
      this.trnx, 
      this.fromCurrency, 
      this.toCurrency, 
      this.userId, 
      this.charge, 
      this.fromAmount, 
      this.toAmount, 
      this.createdAt, 
      this.updatedAt, 
      this.fromCurr, 
      this.toCurr,});

  ExchangeData.fromJson(dynamic json) {
    id = json['id'];
    trnx = json['trnx'];
    fromCurrency = json['from_currency'];
    toCurrency = json['to_currency'];
    userId = json['user_id'];
    charge = json['charge'];
    fromAmount = json['from_amount'];
    toAmount = json['to_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromCurr = json['from_curr'] != null ? FromCurr.fromJson(json['from_curr']) : null;
    toCurr = json['to_curr'] != null ? ToCurr.fromJson(json['to_curr']) : null;
  }
  num? id;
  String? trnx;
  String? fromCurrency;
  String? toCurrency;
  String? userId;
  String? charge;
  String? fromAmount;
  String? toAmount;
  String? createdAt;
  String? updatedAt;
  FromCurr? fromCurr;
  ToCurr? toCurr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trnx'] = trnx;
    map['from_currency'] = fromCurrency;
    map['to_currency'] = toCurrency;
    map['user_id'] = userId;
    map['charge'] = charge;
    map['from_amount'] = fromAmount;
    map['to_amount'] = toAmount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (fromCurr != null) {
      map['from_curr'] = fromCurr?.toJson();
    }
    if (toCurr != null) {
      map['to_curr'] = toCurr?.toJson();
    }
    return map;
  }

}

class ToCurr {
  ToCurr({
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

  ToCurr.fromJson(dynamic json) {
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

class FromCurr {
  FromCurr({
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

  FromCurr.fromJson(dynamic json) {
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