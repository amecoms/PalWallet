import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_wallet/config/dependency.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/app_controller/bloc/app_controller_bloc.dart';
import '../gen/assets.gen.dart';
import '../main.dart';


extension StringExtensions on String {

  String get price {
    return '\$ $this';
  }

  int get toInt {
    try {
      return int.parse(this);
    } catch(e) {
      return toDouble.round();
    }
  }

  double get toDouble {
    try{
      return double.parse(this);
    } catch(e){
      return 0.0;
    }
  }

  List<String> get toList {
    List<String> list = [];
    try {
      json.decode(this).forEach((v) {
        list.add(v.toString());
      });
    } catch(e) {
      list.add(this);
    }
    return list;
  }
  String get numeric {
    return replaceAll(RegExp(r'\D'),'');
  }
  String get capitalCase {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
  String get capitalize {
    return replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.capitalCase).join(' ');
  }

  Color get toColor {
    return AppColor.getColorFromColorCode(this);
  }
  bool get isURl => RegExp(r"^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$")
      .hasMatch(this);

  String get timeAgo => timeago.format(DateTime.parse(this),locale: appContext.read<AppControllerBloc>().state.locale.languageCode);

  Color get statusColor {
    switch(toLowerCase()){
      case '0':
        return const Color(0xFFF59E0B);
      case 'pending':
        return const Color(0xFFF59E0B);
      case '1':
        return const Color(0xFF27C767);
      case 'completed':
        return const Color(0xFF27C767);
      case 'requested':
        return const Color(0xFF2961DC);
      case '2':
        return Colors.redAccent;
      case '3':
        return Colors.blue;
      default:
        return const Color(0xFFF59E0B);
    }
  }

  String get statusName {
    switch(toLowerCase()){
      case '0':
        return appLanguage().pending;
      case 'pending':
        return appLanguage().pending;
      case '1':
        return appLanguage().approved;
      case 'completed':
        return appLanguage().completed;
      case '2':
        return appLanguage().rejected;
      default:
        return appLanguage().pending;
    }
  }

  String get invoiceStatusName {
    switch(toLowerCase()){
      case '0':
        return appLanguage().unpublished;
      case '1':
        return appLanguage().published;
      case '2':
        return appLanguage().cancelled;
      default:
        return appLanguage().unpublished;
    }
  }
  String get paymentStatusName {
    switch(toLowerCase()){
      case '0':
        return appLanguage().unpaid;
      case '1':
        return appLanguage().paid;
      default:
        return appLanguage().unpaid;
    }
  }

  String get escrowStatusName {
    switch(toLowerCase()){
      case '0':
        return appLanguage().on_hold;
      case 'pending':
        return appLanguage().on_hold;
      case '1':
        return appLanguage().released;
      case 'completed':
        return appLanguage().released;
      case '2':
        return appLanguage().rejected;
      case '3':
        return appLanguage().disputed;
      default:
        return appLanguage().pending;
    }
  }

  SvgPicture getIcon({double? iconHeight}){
    switch(toLowerCase()){
      case 'make_escrow':
        return Assets.icons.escrow.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'transfer_money':
        return Assets.icons.transferMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'request_money':
        return Assets.icons.requestMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'merchant_payment':
        return Assets.icons.transferMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'money_exchange':
        return Assets.icons.exchangeMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'create_voucher':
        return Assets.icons.voucher.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'voucher_commission':
        return Assets.icons.voucher.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'deposit':
        return Assets.icons.deposit.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'withdraw_money':
        return Assets.icons.withdraw.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'add_balance':
        return Assets.icons.addMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'cash_out':
        return Assets.icons.cashOut.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      case 'invoice_payment':
        return Assets.icons.invoicePayment.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
      default:
        return Assets.icons.transferMoney.svg(height: iconHeight ?? 20.h, color: AppColor.iconColor);
    }
  }
}
