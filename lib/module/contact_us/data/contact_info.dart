class ContactInfo {
  ContactInfo({
      this.status, 
      this.data, 
      this.error,});

  ContactInfo.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ContactData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  ContactData? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ContactData {
  ContactData({
      this.latitude, 
      this.longitude, 
      this.subtitle, 
      this.description, 
      this.address, 
      this.phone, 
      this.email,});

  ContactData.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    subtitle = json['subtitle'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
  }
  dynamic latitude;
  dynamic longitude;
  String? subtitle;
  String? description;
  String? address;
  String? phone;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['subtitle'] = subtitle;
    map['description'] = description;
    map['address'] = address;
    map['phone'] = phone;
    map['email'] = email;
    return map;
  }

}