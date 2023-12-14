class Dashboard {
  Dashboard({
    this.success,
    this.message,
    this.response,});

  Dashboard.fromJson(dynamic json) {
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
    this.transactions,
    this.totalTransferMoney,
    this.totalExchange,
    this.totalDeposit,
    this.totalWithdraw,});

  Response.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(TransactionData.fromJson(v));
      });
    }
    totalTransferMoney = json['totalTransferMoney'];
    totalExchange = json['totalExchange'];
    totalDeposit = json['totalDeposit'];
    totalWithdraw = json['totalWithdraw'];
  }
  List<Wallets>? wallets;
  List<TransactionData>? transactions;
  num? totalTransferMoney;
  num? totalExchange;
  num? totalDeposit;
  num? totalWithdraw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    map['totalTransferMoney'] = totalTransferMoney;
    map['totalExchange'] = totalExchange;
    map['totalDeposit'] = totalDeposit;
    map['totalWithdraw'] = totalWithdraw;
    return map;
  }

}

class TransactionData {
  TransactionData({
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

  TransactionData.fromJson(dynamic json) {
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
