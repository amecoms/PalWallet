import 'dart:convert';

class DepositFrom {
  DepositFrom({
      this.success, 
      this.message, 
      this.response,});

  DepositFrom.fromJson(dynamic json) {
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
      this.recentDeposits,});

  Response.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
    if (json['recent_deposits'] != null) {
      recentDeposits = [];
      json['recent_deposits'].forEach((v) {
        recentDeposits?.add(RecentDeposits.fromJson(v));
      });
    }
  }
  List<Wallets>? wallets;
  List<RecentDeposits>? recentDeposits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    if (recentDeposits != null) {
      map['recent_deposits'] = recentDeposits?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RecentDeposits {
  RecentDeposits({
      this.id, 
      this.userId, 
      this.userType, 
      this.userInfo, 
      this.status, 
      this.txnId, 
      this.createdAt, 
      this.updatedAt, 
      this.amount, 
      this.method, 
      this.currencyId, 
      this.invoice, 
      this.currencyInfo, 
      this.trxDetails, 
      this.charge, 
      this.currency,});

  RecentDeposits.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    userInfo = json['user_info'] != null ? UserInfo.fromJson(jsonDecode(json['user_info'].toString().replaceAll(r'\', ""))) : null;
    status = json['status'];
    txnId = json['txn_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    method = json['method'];
    currencyId = json['currency_id'];
    invoice = json['invoice'];
    currencyInfo = json['currency_info'] != null ? CurrencyInfo.fromJson(jsonDecode(json['currency_info'].toString().replaceAll(r'\', ""))) : null;
    trxDetails = json['trx_details'];
    charge = json['charge'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? userId;
  String? userType;
  UserInfo? userInfo;
  String? status;
  String? txnId;
  String? createdAt;
  String? updatedAt;
  String? amount;
  String? method;
  String? currencyId;
  dynamic invoice;
  CurrencyInfo? currencyInfo;
  dynamic trxDetails;
  dynamic charge;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_type'] = userType;
    if (userInfo != null) {
      map['user_info'] = userInfo?.toJson();
    }
    map['status'] = status;
    map['txn_id'] = txnId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['amount'] = amount;
    map['method'] = method;
    map['currency_id'] = currencyId;
    map['invoice'] = invoice;
    if (currencyInfo != null) {
      map['currency_info'] = currencyInfo?.toJson();
    }
    map['trx_details'] = trxDetails;
    map['charge'] = charge;
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

class CurrencyInfo {
  CurrencyInfo({
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

  CurrencyInfo.fromJson(dynamic json) {
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

class UserInfo {
  UserInfo({
      this.id, 
      this.name, 
      this.email, 
      this.photo, 
      this.phone, 
      this.country, 
      this.city, 
      this.address, 
      this.zip, 
      this.status, 
      this.emailVerified, 
      this.verificationLink, 
      this.verifyCode, 
      this.kycStatus, 
      this.kycInfo, 
      this.kycRejectReason, 
      this.twoFaStatus, 
      this.twoFa, 
      this.twoFaCode, 
      this.createdAt, 
      this.updatedAt,});

  UserInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    zip = json['zip'];
    status = json['status'];
    emailVerified = json['email_verified'];
    verificationLink = json['verification_link'];
    verifyCode = json['verify_code'];
    kycStatus = json['kyc_status'];
    kycInfo = json['kyc_info'] != null ? KycInfo.fromJson(json['kyc_info']) : null;
    kycRejectReason = json['kyc_reject_reason'];
    twoFaStatus = json['two_fa_status'];
    twoFa = json['two_fa'];
    twoFaCode = json['two_fa_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? email;
  dynamic photo;
  String? phone;
  String? country;
  dynamic city;
  String? address;
  dynamic zip;
  String? status;
  String? emailVerified;
  dynamic verificationLink;
  dynamic verifyCode;
  String? kycStatus;
  KycInfo? kycInfo;
  dynamic kycRejectReason;
  String? twoFaStatus;
  String? twoFa;
  dynamic twoFaCode;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['photo'] = photo;
    map['phone'] = phone;
    map['country'] = country;
    map['city'] = city;
    map['address'] = address;
    map['zip'] = zip;
    map['status'] = status;
    map['email_verified'] = emailVerified;
    map['verification_link'] = verificationLink;
    map['verify_code'] = verifyCode;
    map['kyc_status'] = kycStatus;
    if (kycInfo != null) {
      map['kyc_info'] = kycInfo?.toJson();
    }
    map['kyc_reject_reason'] = kycRejectReason;
    map['two_fa_status'] = twoFaStatus;
    map['two_fa'] = twoFa;
    map['two_fa_code'] = twoFaCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class KycInfo {
  KycInfo({
      this.nid, 
      this.image, 
      this.details,});

  KycInfo.fromJson(dynamic json) {
    nid = json['nid'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? nid;
  Image? image;
  Details? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid'] = nid;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}

class Details {
  Details({
      this.descriptionOfAddress,});

  Details.fromJson(dynamic json) {
    descriptionOfAddress = json['description_of_address'];
  }
  String? descriptionOfAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description_of_address'] = descriptionOfAddress;
    return map;
  }

}

class Image {
  Image({
      this.nidScreenshot,});

  Image.fromJson(dynamic json) {
    nidScreenshot = json['nid_screenshot'];
  }
  String? nidScreenshot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid_screenshot'] = nidScreenshot;
    return map;
  }

}

class Wallets {
  Wallets({
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

  Wallets.fromJson(dynamic json) {
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