class Gateways {
  Gateways({
      this.success, 
      this.message, 
      this.response,});

  Gateways.fromJson(dynamic json) {
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
      this.methods,});

  Response.fromJson(dynamic json) {
    if (json['methods'] != null) {
      methods = [];
      json['methods'].forEach((v) {
        methods?.add(Methods.fromJson(v));
      });
    }
  }
  List<Methods>? methods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (methods != null) {
      map['methods'] = methods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Methods {
  Methods({
      this.id, 
      this.name, 
      this.fixedCharge, 
      this.percentCharge, 
      this.details, 
      this.type,});

  Methods.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    fixedCharge = json['fixed_charge'];
    percentCharge = json['percent_charge'];
    details = json['details'];
    type = json['type'];
  }
  num? id;
  String? name;
  dynamic fixedCharge;
  dynamic percentCharge;
  dynamic details;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['fixed_charge'] = fixedCharge;
    map['percent_charge'] = percentCharge;
    map['details'] = details;
    map['type'] = type;
    return map;
  }

}