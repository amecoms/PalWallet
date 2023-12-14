import 'package:flutter/material.dart';

class DrawerTab{
  String title;
  List<SubTab> tabs;
  String? route;
  dynamic arguments;

  DrawerTab({required this.title, required this.tabs, this.route,this.arguments});
}
class SubTab{
  String title;
  String? route;
  String icon;
  dynamic arguments;

  SubTab({required this.title, this.route,this.arguments,required this.icon});
}