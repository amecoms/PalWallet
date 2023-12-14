class WithdrawHistory {
  WithdrawHistory({
      this.success, 
      this.message, 
      this.response,});

  WithdrawHistory.fromJson(dynamic json) {
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
      this.withdrawals,});

  Response.fromJson(dynamic json) {
    withdrawals = json['withdrawals'] != null ? Withdrawals.fromJson(json['withdrawals']) : null;
  }
  Withdrawals? withdrawals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (withdrawals != null) {
      map['withdrawals'] = withdrawals?.toJson();
    }
    return map;
  }

}

class Withdrawals {
  Withdrawals({
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

  Withdrawals.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WithdrawData.fromJson(v));
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
  List<WithdrawData>? data;
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

class WithdrawData {
  WithdrawData({
      this.id, 
      this.trx, 
      this.userId, 
      this.merchantId, 
      this.methodName,
      this.agentId,
      this.methodId, 
      this.currencyId, 
      this.amount, 
      this.charge, 
      this.totalAmount, 
      this.userData, 
      this.status, 
      this.rejectReason, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,});

  WithdrawData.fromJson(dynamic json) {
    id = json['id'];
    trx = json['trx'];
    userId = json['user_id'];
    merchantId = json['merchant_id'];
    methodName = json['method']['name'];
    agentId = json['agent_id'];
    methodId = json['method_id'];
    currencyId = json['currency_id'];
    amount = json['amount'];
    charge = json['charge'];
    totalAmount = json['total_amount'];
    userData = json['user_data'];
    status = json['status'];
    rejectReason = json['reject_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? trx;
  String? userId;
  dynamic merchantId;
  dynamic agentId;
  String? methodId;
  String? methodName;
  String? currencyId;
  String? amount;
  String? charge;
  String? totalAmount;
  String? userData;
  String? status;
  dynamic rejectReason;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trx'] = trx;
    map['user_id'] = userId;
    map['merchant_id'] = merchantId;
    map['agent_id'] = agentId;
    map['method_id'] = methodId;
    map['currency_id'] = currencyId;
    map['amount'] = amount;
    map['charge'] = charge;
    map['total_amount'] = totalAmount;
    map['user_data'] = userData;
    map['status'] = status;
    map['reject_reason'] = rejectReason;
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