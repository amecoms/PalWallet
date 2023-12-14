import '../../../main_page/data/dashboard.dart';

class Transactions {
  Transactions({
      this.success, 
      this.message, 
      this.response,});

  Transactions.fromJson(dynamic json) {
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
      this.transactions, 
      this.remarkList, 
      this.remark, 
      this.search,});

  Response.fromJson(dynamic json) {
    transactions = json['transactions'] != null ? AllTransactions.fromJson(json['transactions']) : null;
    remarkList = json['remark_list'] != null ? json['remark_list'].cast<String>() : [];
    remark = json['remark'];
    search = json['search'];
  }
  AllTransactions? transactions;
  List<String>? remarkList;
  String? remark;
  String? search;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transactions != null) {
      map['transactions'] = transactions?.toJson();
    }
    map['remark_list'] = remarkList;
    map['remark'] = remark;
    map['search'] = search;
    return map;
  }

}

class AllTransactions {
  AllTransactions({
      this.currentPage, 
      this.data, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl, 
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total,});

  AllTransactions.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransactionData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  num? currentPage;
  List<TransactionData>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}