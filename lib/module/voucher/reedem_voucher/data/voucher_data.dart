class VoucherData {
  VoucherData({
      this.success, 
      this.message, 
      this.response,});

  VoucherData.fromJson(dynamic json) {
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
      this.recentRedeemed,});

  Response.fromJson(dynamic json) {
    if (json['recent_redeemed'] != null) {
      recentRedeemed = [];
      json['recent_redeemed'].forEach((v) {
        recentRedeemed?.add(RecentRedeemed.fromJson(v));
      });
    }
  }
  List<RecentRedeemed>? recentRedeemed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recentRedeemed != null) {
      map['recent_redeemed'] = recentRedeemed?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RecentRedeemed {
  RecentRedeemed({
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

  RecentRedeemed.fromJson(dynamic json) {
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
  String? reedemedBy;
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