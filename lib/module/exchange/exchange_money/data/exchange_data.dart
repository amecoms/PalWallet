class ExchangeData {
  ExchangeData({
      this.success, 
      this.message, 
      this.response,});

  ExchangeData.fromJson(dynamic json) {
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
      this.currencies, 
      this.charge, 
      this.recentExchanges,});

  Response.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
    if (json['currencies'] != null) {
      currencies = [];
      json['currencies'].forEach((v) {
        currencies?.add(Currencies.fromJson(v));
      });
    }
    charge = json['charge'] != null ? Charge.fromJson(json['charge']) : null;
    if (json['recent_exchanges'] != null) {
      recentExchanges = [];
      json['recent_exchanges'].forEach((v) {
        recentExchanges?.add(RecentExchanges.fromJson(v));
      });
    }
  }
  List<Wallets>? wallets;
  List<Currencies>? currencies;
  Charge? charge;
  List<RecentExchanges>? recentExchanges;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    if (currencies != null) {
      map['currencies'] = currencies?.map((v) => v.toJson()).toList();
    }
    if (charge != null) {
      map['charge'] = charge?.toJson();
    }
    if (recentExchanges != null) {
      map['recent_exchanges'] = recentExchanges?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RecentExchanges {
  RecentExchanges({
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

  RecentExchanges.fromJson(dynamic json) {
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

class Charge {
  Charge({
      this.percentCharge, 
      this.fixedCharge, 
      this.minimum, 
      this.maximum,});

  Charge.fromJson(dynamic json) {
    percentCharge = json['percent_charge'];
    fixedCharge = json['fixed_charge'];
    minimum = json['minimum'];
    maximum = json['maximum'];
  }
  String? percentCharge;
  String? fixedCharge;
  String? minimum;
  String? maximum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent_charge'] = percentCharge;
    map['fixed_charge'] = fixedCharge;
    map['minimum'] = minimum;
    map['maximum'] = maximum;
    return map;
  }

}

class Currencies {
  Currencies({
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

  Currencies.fromJson(dynamic json) {
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