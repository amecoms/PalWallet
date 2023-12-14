class EscrowDispute {
  EscrowDispute({
      this.success, 
      this.message, 
      this.response,});

  EscrowDispute.fromJson(dynamic json) {
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
      this.escrow, 
      this.messages,});

  Response.fromJson(dynamic json) {
    escrow = json['escrow'] != null ? Escrow.fromJson(json['escrow']) : null;
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  Escrow? escrow;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (escrow != null) {
      map['escrow'] = escrow?.toJson();
    }
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Messages {
  Messages({
      this.id, 
      this.escrowId, 
      this.userId, 
      this.adminId, 
      this.message, 
      this.file, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  Messages.fromJson(dynamic json) {
    id = json['id'];
    escrowId = json['escrow_id'];
    userId = json['user_id'].toString();
    adminId = json['admin_id'];
    message = json['message'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? id;
  String? escrowId;
  String? userId;
  dynamic adminId;
  String? message;
  String? file;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['escrow_id'] = escrowId;
    map['user_id'] = userId;
    map['admin_id'] = adminId;
    map['message'] = message;
    map['file'] = file;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
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

  User.fromJson(dynamic json) {
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
      this.details,});

  KycInfo.fromJson(dynamic json) {
    nid = json['nid'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? nid;
  Details? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid'] = nid;
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


class Escrow {
  Escrow({
      this.id, 
      this.trnx, 
      this.userId, 
      this.recipientId, 
      this.description, 
      this.amount, 
      this.payCharge, 
      this.charge, 
      this.currencyId, 
      this.status, 
      this.disputeCreated, 
      this.returnedTo, 
      this.createdAt, 
      this.updatedAt, 
      this.currency,});

  Escrow.fromJson(dynamic json) {
    id = json['id'];
    trnx = json['trnx'];
    userId = json['user_id'];
    recipientId = json['recipient_id'];
    description = json['description'];
    amount = json['amount'];
    payCharge = json['pay_charge'];
    charge = json['charge'];
    currencyId = json['currency_id'];
    status = json['status'];
    disputeCreated = json['dispute_created'];
    returnedTo = json['returned_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  num? id;
  String? trnx;
  String? userId;
  String? recipientId;
  String? description;
  String? amount;
  String? payCharge;
  String? charge;
  String? currencyId;
  String? status;
  String? disputeCreated;
  dynamic returnedTo;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trnx'] = trnx;
    map['user_id'] = userId;
    map['recipient_id'] = recipientId;
    map['description'] = description;
    map['amount'] = amount;
    map['pay_charge'] = payCharge;
    map['charge'] = charge;
    map['currency_id'] = currencyId;
    map['status'] = status;
    map['dispute_created'] = disputeCreated;
    map['returned_to'] = returnedTo;
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