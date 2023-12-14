import 'dart:developer';
import 'dart:math' as Math;

import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

enum ServerDateTime { Date, Time}

class Helper{
  static void hideKeyboard(){
    try{
      FocusManager.instance.primaryFocus!.unfocus();
    } catch(e) {
      FocusScope.of(appContext).unfocus();
    }
  }
  static String getTime(String dateTime){
    DateTime time = DateTime.parse(dateTime);
    return '${time.hour.toString().padLeft(2,'0')}h${time.minute.toString().length==1 ? '0${time.minute}' : time.minute}';
  }

  static bool isToday(String date,{int inDay=0}){
    DateTime dateTime = DateTime.parse('${DateTime.now().toString().split(' ')[0]} 00:00:00');
    DateTime _pickedDate = DateTime.parse('${DateTime.parse(date).toString().split(' ')[0]} 00:00:00');
    return _pickedDate.difference(dateTime).inDays == inDay;
  }

  static bool isEmailValid(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  static sendMail(String email,{String? subject}) async {
    if (!await launchUrl(Uri(scheme: 'mailto', path: email,query: subject != null ? encodeQueryParameters(<String, String>{
      'subject': subject,
    }) : null))) {
      throw 'Could not launch $email';
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static Future<String?> openDatePicker({String date=''}) async {
    DateTime selectedDate;
    try {
      selectedDate = date.isNotEmpty ? DateTime.parse(date) : DateTime.now();
    } catch (e) {
      selectedDate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
      context: appContext,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary.withOpacity(0.5),
              onPrimary: AppColor.primary,
              onSurface: AppColor.primary,
              background: AppColor.primary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColor.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      }
    );
    if (picked != null && picked != selectedDate) {
      return AppConstant.defaultDateFormat.format(picked);
    } else {
      return null;
    }
  }
  static Future<String?> openTimePicker({String time=''}) async {
    TimeOfDay selectedTime;
    try {
      if(time.isEmpty){
        selectedTime = TimeOfDay.now();
      } else {
        List<String> splitTime = time.split(":");
        selectedTime = TimeOfDay(
          hour: splitTime[0].toInt,
          minute: splitTime[1].toInt,
        );
      }
    } catch (e) {
      selectedTime = TimeOfDay.now();
    }
    final TimeOfDay? picked = await showTimePicker(
      context: appContext,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      return '${picked.hour.toString().padLeft(2,'0')}:${picked.minute.toString().padLeft(2,'0')}:00';
    } else {
      return null;
    }
  }

  static goBrowser(String? url) async {
    if(url == null) return;
    if(!await launchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalNonBrowserApplication);
    } else {
      log('Could not launch $url');
    }
  }
  static makeCall(String number) async {
    if (!await launchUrl(Uri(scheme: 'tel', path: number,))) {
      log('Could not launch $number');
    }
  }

  static copyText(String text) async {
    try{
      await Clipboard.setData(ClipboardData(text: text));
      SuccessMessage(message: appLanguage().copiedSuccessfully);
    } catch(e){}
  }

  static String generateString({int length = 10}){
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Math.Random _rnd = Math.Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static isTimeInside({required String time, Duration? duration}) {
    DateTime dateTime = DateTime.now().add(duration ?? const Duration(milliseconds: 0));
    DateTime _pickedDate = DateTime.parse(time);
    return dateTime.difference(_pickedDate).inSeconds>=0;
  }

  static String getFormatDate(String format,String date){
    try{
      return DateFormat(format).format(DateTime.parse(date));
    } catch(e){
      return date;
    }
  }

  static Color getStatusColor(String status){
    switch(status.toLowerCase()){
      case '0':
        return const Color(0xFFF59E0B);
      case '1':
        return const Color(0xFF27C767);
      case 'requested':
        return const Color(0xFF2961DC);
      case '2':
        return Colors.redAccent;
      default:
        return const Color(0xFFF59E0B);
    }
  }

  static String getUserRole(String role){
    switch(role){
      case 'PROJECT_MANAGER':
        return 'Project manager';
      case 'LOGISTICS_MANAGER':
        return 'Logistics manager';
      case 'ENV_WORKER':
        return 'Environment worker';
      case 'DELIVERY_PARTNER':
        return 'Delivery professional';
      case 'CONTRACTOR':
        return 'Contractor';
      case 'RESOURCE_OP':
        return 'Resource Operator';
      case 'SUPPLIER':
        return 'Supplier';
      case 'SITE_SUPERVISOR':
        return 'Site supervisor';
      default:
        return role;
    }
  }

  static String getDeliveryStatus(String status){
    switch(status){
      case 'PENDING':
        return 'Requested';
      case 'ACCEPTED':
        return 'Booked';
      case 'DECLINED':
        return 'Declined';
      case 'INPROGRESS':
        return 'In progress';
      case 'DELAYED':
        return 'Delayed';
      case 'COMPLETED':
        return 'Completed';
      default:
        return status;
    }
  }

  static DateTime getNextSlot(DateTime dateTime) {
    if (dateTime.minute<15) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 15);
    }else if (dateTime.minute<30) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 30);
    } else if (dateTime.minute<45) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 45);
    }else {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour+1, 0);
    }
  }

}