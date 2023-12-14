import 'package:flutter/material.dart';

class FormData {
  FormData({
    this.success,
    this.message,
    this.response,});

  FormData.fromJson(dynamic json) {
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
    this.data,});

  Response.fromJson(dynamic json) {
    if (json['kyc_form_data'] != null) {
      data = [];
      json['kyc_form_data'].forEach((v) {
        data?.add(
            DynamicForm(
              type: v['type'].toString(),
              name: v['name'].toString(),
              required: v['required'].toString() == '1',
              label: v['name'].toString().replaceAll('_', ' '),
              isTextField:['1','3'].contains(v['type'].toString()),
              controller: TextEditingController(),
            )
        );
      });
    }
  }

  List<DynamicForm>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      //map['kyc_form_data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DynamicForm {
  DynamicForm({
      this.type, 
      this.name, 
      this.required,
      this.label,
      this.data,
      this.isTextField,
      this.controller,
  });

  String? type;
  String? name;
  bool? required;
  String? label;
  dynamic data;
  bool? isTextField;
  TextEditingController? controller;
}