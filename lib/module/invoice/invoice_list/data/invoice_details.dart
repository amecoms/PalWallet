class InvoiceDetails {
  InvoiceDetails({
      this.success, 
      this.message, 
      this.response,});

  InvoiceDetails.fromJson(dynamic json) {
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
    this.invoice,
    this.invoiceItems,
    this.fromAddress,
  });

  Response.fromJson(dynamic json) {
    invoice = json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null;
    fromAddress = json['from_address'] != null ? FromAddress.fromJson(json['from_address']) : null;
    if (json['invoice_items'] != null) {
      invoiceItems = [];
      json['invoice_items'].forEach((v) {
        invoiceItems?.add(InvoiceItems.fromJson(v));
      });
    }
  }
  Invoice? invoice;
  FromAddress? fromAddress;
  List<InvoiceItems>? invoiceItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (invoice != null) {
      map['invoice'] = invoice?.toJson();
    }
    if (fromAddress != null) {
      map['from_address'] = fromAddress?.toJson();
    }
    if (invoiceItems != null) {
      map['invoice_items'] = invoiceItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class InvoiceItems {
  InvoiceItems({
      this.id, 
      this.invoiceId, 
      this.name, 
      this.amount, 
      this.createdAt, 
      this.updatedAt,});

  InvoiceItems.fromJson(dynamic json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    name = json['name'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? invoiceId;
  String? name;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['invoice_id'] = invoiceId;
    map['name'] = name;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Invoice {
  Invoice({
      this.id, 
      this.userId, 
      this.number, 
      this.currencyId, 
      this.invoiceTo, 
      this.email, 
      this.address, 
      this.charge, 
      this.finalAmount, 
      this.getAmount, 
      this.paymentStatus, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Invoice.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    number = json['number'];
    currencyId = json['currency_id'];
    invoiceTo = json['invoice_to'];
    email = json['email'];
    address = json['address'];
    charge = json['charge'];
    finalAmount = json['final_amount'];
    getAmount = json['get_amount'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userId;
  String? number;
  String? currencyId;
  String? invoiceTo;
  String? email;
  String? address;
  String? charge;
  String? finalAmount;
  String? getAmount;
  String? paymentStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['number'] = number;
    map['currency_id'] = currencyId;
    map['invoice_to'] = invoiceTo;
    map['email'] = email;
    map['address'] = address;
    map['charge'] = charge;
    map['final_amount'] = finalAmount;
    map['get_amount'] = getAmount;
    map['payment_status'] = paymentStatus;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class FromAddress {
  FromAddress({
    this.phone,
    this.email,
    this.address,});

  FromAddress.fromJson(dynamic json) {
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
  }
  String? phone;
  String? email;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['email'] = email;
    map['address'] = address;
    return map;
  }

}