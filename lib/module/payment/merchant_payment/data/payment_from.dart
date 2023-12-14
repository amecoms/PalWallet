class PaymentFrom {
  PaymentFrom({
      this.success, 
      this.message, 
      this.response,});

  PaymentFrom.fromJson(dynamic json) {
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
      this.wallets, 
      this.recentPayments, 
      this.charge,});

  Response.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
    recentPayments = json['recent_payments'] != null ? RecentPayments.fromJson(json['recent_payments']) : null;
    charge = json['charge'] != null ? Charge.fromJson(json['charge']) : null;
  }
  List<Wallets>? wallets;
  RecentPayments? recentPayments;
  Charge? charge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    if (recentPayments != null) {
      map['recent_payments'] = recentPayments?.toJson();
    }
    if (charge != null) {
      map['charge'] = charge?.toJson();
    }
    return map;
  }

}

class Charge {
  Charge({
      this.percentCharge, 
      this.fixedCharge,});

  Charge.fromJson(dynamic json) {
    percentCharge = json['percent_charge'];
    fixedCharge = json['fixed_charge'];
  }
  String? percentCharge;
  String? fixedCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent_charge'] = percentCharge;
    map['fixed_charge'] = fixedCharge;
    return map;
  }

}

class RecentPayments {
  RecentPayments({
      this.currentPage, 
      this.data, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl, 
      this.links, 
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total,});

  RecentPayments.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  num? currentPage;
  List<PaymentData>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  List<Links>? links;
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
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

class Links {
  Links({
      this.url, 
      this.label, 
      this.active,});

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
  dynamic url;
  String? label;
  bool? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }

}

class PaymentData {
  PaymentData({
      this.id, 
      this.trnx, 
      this.userId, 
      this.userType, 
      this.currencyId, 
      this.walletId, 
      this.charge, 
      this.amount, 
      this.remark, 
      this.type, 
      this.details, 
      this.invoiceNum, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,});

  PaymentData.fromJson(dynamic json) {
    id = json['id'];
    trnx = json['trnx'];
    userId = json['user_id'];
    userType = json['user_type'];
    currencyId = json['currency_id'];
    walletId = json['wallet_id'];
    charge = json['charge'];
    amount = json['amount'];
    remark = json['remark'];
    type = json['type'];
    details = json['details'];
    invoiceNum = json['invoice_num'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? trnx;
  String? userId;
  String? userType;
  String? currencyId;
  String? walletId;
  String? charge;
  String? amount;
  String? remark;
  String? type;
  String? details;
  dynamic invoiceNum;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trnx'] = trnx;
    map['user_id'] = userId;
    map['user_type'] = userType;
    map['currency_id'] = currencyId;
    map['wallet_id'] = walletId;
    map['charge'] = charge;
    map['amount'] = amount;
    map['remark'] = remark;
    map['type'] = type;
    map['details'] = details;
    map['invoice_num'] = invoiceNum;
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

class Wallets {
  Wallets({
      this.id, 
      this.userId, 
      this.userType, 
      this.currencyId, 
      this.balance, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,});

  Wallets.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    currencyId = json['currency_id'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? userId;
  String? userType;
  String? currencyId;
  String? balance;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_type'] = userType;
    map['currency_id'] = currencyId;
    map['balance'] = balance;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    return map;
  }

}