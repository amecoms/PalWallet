class RequestMoney {
  RequestMoney({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.currencyId, 
      this.requestAmount, 
      this.charge, 
      this.finalAmount, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.currency, 
      this.receiver,});

  RequestMoney.fromJson(dynamic json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    currencyId = json['currency_id'];
    requestAmount = json['request_amount'];
    charge = json['charge'];
    finalAmount = json['final_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  num? id;
  String? senderId;
  String? receiverId;
  String? currencyId;
  String? requestAmount;
  String? charge;
  String? finalAmount;
  String? status;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  Receiver? receiver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['currency_id'] = currencyId;
    map['request_amount'] = requestAmount;
    map['charge'] = charge;
    map['final_amount'] = finalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    if (receiver != null) {
      map['receiver'] = receiver?.toJson();
    }
    return map;
  }

}

class Receiver {
  Receiver({
      this.id, 
      this.name, 
      this.email, 
      this.photo,});

  Receiver.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
  num? id;
  String? name;
  String? email;
  dynamic photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['photo'] = photo;
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