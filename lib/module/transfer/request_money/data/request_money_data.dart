import 'package:genius_wallet/module/transfer/request_money/data/request_money.dart';

class RequestMoneyData {
  RequestMoneyData({
      this.success, 
      this.message, 
      this.response,});

  RequestMoneyData.fromJson(dynamic json) {
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
      this.charge, 
      this.recentRequests,});

  Response.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
    if (json['currency'] != null) {
      currency = [];
      json['currency'].forEach((v) {
        currency?.add(Currency.fromJson(v));
      });
    }
    charge = json['charge'] != null ? Charge.fromJson(json['charge']) : null;
    if (json['recent_requests'] != null) {
      recentRequests = [];
      json['recent_requests'].forEach((v) {
        recentRequests?.add(RequestMoney.fromJson(v));
      });
    }
  }
  List<Wallets>? wallets;
  List<Currency>? currency;
  Charge? charge;
  List<RequestMoney>? recentRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    if (currency != null) {
      map['currency'] = currency?.map((v) => v.toJson()).toList();
    }
    if (charge != null) {
      map['charge'] = charge?.toJson();
    }
    if (recentRequests != null) {
      map['recent_requests'] = recentRequests?.map((v) => v.toJson()).toList();
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