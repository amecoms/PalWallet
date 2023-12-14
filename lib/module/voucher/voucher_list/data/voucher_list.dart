class VoucherList {
  VoucherList({
      this.success, 
      this.message, 
      this.response,});

  VoucherList.fromJson(dynamic json) {
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
      this.vouchers,});

  Response.fromJson(dynamic json) {
    vouchers = json['vouchers'] != null ? Vouchers.fromJson(json['vouchers']) : null;
  }
  Vouchers? vouchers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (vouchers != null) {
      map['vouchers'] = vouchers?.toJson();
    }
    return map;
  }

}

class Vouchers {
  Vouchers({
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

  Vouchers.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Voucher.fromJson(v));
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
  List<Voucher>? data;
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


class Voucher {
  Voucher({
      this.id, 
      this.currencyId, 
      this.userId, 
      this.amount, 
      this.code, 
      this.status, 
      this.reedemedBy, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,});

  Voucher.fromJson(dynamic json) {
    id = json['id'];
    currencyId = json['currency_id'];
    userId = json['user_id'];
    amount = json['amount'];
    code = json['code'];
    status = json['status'];
    reedemedBy = json['reedemed_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? currencyId;
  String? userId;
  String? amount;
  String? code;
  String? status;
  dynamic reedemedBy;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['currency_id'] = currencyId;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['code'] = code;
    map['status'] = status;
    map['reedemed_by'] = reedemedBy;
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