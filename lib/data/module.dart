import '../config/dependency.dart';

class Module {
  Module({
      this.success, 
      this.message, 
      this.response,});

  Module.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['response'] != null) {
      response = [];
      json['response'][0].forEach((v) {
        response?.add(Response.fromJson(v));
      });
      transferMoney = response!.where((element) => element.module == 'transfer-money').first.status == "1";
      requestMoney = response!.where((element) => element.module == 'request-money').first.status == "1";
      exchangeMoney = response!.where((element) => element.module == 'exchange-money').first.status == "1";
      makePayment = response!.where((element) => element.module == 'make-payment').first.status == "1";
      createVoucher = response!.where((element) => element.module == 'create-voucher').first.status == "1";
      withdrawMoney = response!.where((element) => element.module == 'withdraw-money').first.status == "1";
      createInvoice = response!.where((element) => element.module == 'create-invoice').first.status == "1";
      makeEscrow = response!.where((element) => element.module == 'make-escrow').first.status == "1";
      deposit = response!.where((element) => element.module == 'deposit').first.status == "1";
      cashOut = response!.where((element) => element.module == 'cash-out').first.status == "1";
    }
  }
  bool? success;
  String? message;
  List<Response>? response;
  bool? transferMoney,requestMoney,exchangeMoney,makePayment,createVoucher,withdrawMoney,createInvoice,makeEscrow,deposit,cashOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static Module? getModule(){
    try{
      return instance.get<Module>();
    } catch(e){
      return null;
    }
  }

}

class Response {
  Response({
      this.id, 
      this.module, 
      this.status, 
      this.kyc, 
      this.createdAt, 
      this.updatedAt,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    module = json['module'];
    status = json['status'];
    kyc = json['kyc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? module;
  String? status;
  String? kyc;
  dynamic createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['module'] = module;
    map['status'] = status;
    map['kyc'] = kyc;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}