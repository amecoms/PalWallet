class WithdrawMethod {
  WithdrawMethod({
      this.success, 
      this.message, 
      this.response,});

  WithdrawMethod.fromJson(dynamic json) {
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
      this.currencyId, 
      this.name, 
      this.withdrawInstruction, 
      this.minAmount, 
      this.maxAmount, 
      this.fixedCharge, 
      this.percentCharge, 
      this.userData, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Methods.fromJson(dynamic json) {
    id = json['id'];
    currencyId = json['currency_id'];
    name = json['name'];
    withdrawInstruction = json['withdraw_instruction'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    fixedCharge = json['fixed_charge'];
    percentCharge = json['percent_charge'];
    userData = json['user_data'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? currencyId;
  String? name;
  String? withdrawInstruction;
  String? minAmount;
  String? maxAmount;
  String? fixedCharge;
  String? percentCharge;
  dynamic userData;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['currency_id'] = currencyId;
    map['name'] = name;
    map['withdraw_instruction'] = withdrawInstruction;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['fixed_charge'] = fixedCharge;
    map['percent_charge'] = percentCharge;
    map['user_data'] = userData;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}