
class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.city,
    this.zip,
    this.address,
    this.profilePhoto,
    this.emailVerified,
    this.kycStatus,
    this.kycRejectReason,
    this.twoFaStatus,
    this.twoFa,
    this.twoFaCode,
    this.status,
    this.createdAt,
    this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    address = json['address'];
    profilePhoto = json['profile_photo'] ?? json['photo'];
    emailVerified = json['email_verified'].runtimeType == String ? json['email_verified'] == "1" : json['email_verified'];
    kycStatus = json['kyc_status'] ?? '0';
    kycRejectReason = json['kyc_reject_reason'] ?? '0';
    twoFaStatus = json['two_fa_status'] ?? '0';
    twoFa = json['two_fa'] ?? '0';
    twoFaCode = json['two_fa_code'].toString();
    status = json['status'] ?? '0';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? email;
  String? phone;
  String? country;
  String? city;
  String? zip;
  String? address;
  String? profilePhoto;
  bool? emailVerified;
  String? kycStatus;
  String? kycRejectReason;
  String? twoFaStatus;
  String? twoFa;
  String? twoFaCode;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['country'] = country;
    map['city'] = city;
    map['zip'] = zip;
    map['address'] = address;
    map['profile_photo'] = profilePhoto;
    map['email_verified'] = emailVerified;
    map['kyc_status'] = kycStatus;
    map['kyc_reject_reason'] = kycRejectReason;
    map['two_fa_status'] = twoFaStatus;
    map['two_fa'] = twoFa;
    map['two_fa_code'] = twoFaCode;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}