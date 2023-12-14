import 'package:flutter/material.dart';
import 'package:genius_wallet/data/module.dart';
import 'package:genius_wallet/data/settings.dart';
import 'package:genius_wallet/gen/assets.gen.dart';
import '../../../../app_helper/enums.dart';
import '../../../../custom_icons/my_flutter_app_icons.dart' as CustomIcon;
import '../../../../data/auth.dart';
import '../../../../main.dart';
import '../../../../module/main_page/data/dashboard.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/url.dart';

import '../../../data/user.dart';
import '../data/drawer_tab.dart';

class MainPageState {
  PageState pageState;
  Dashboard? dashboard;
  User? user = Auth.getAuth()!.response!.user!;
  Settings? settings;
  Module? module = Module.getModule();
  List<DrawerTab> drawerTabs = [];


  MainPageState({
    this.dashboard,
    this.pageState = PageState.Loading,
    this.user,
    this.settings
  }){
    user = Auth.getAuth()!.response!.user!;
    drawerTabs = [
      DrawerTab(
          title: appLanguage().transfer_request,
          tabs: [
            if(module!.transferMoney!)
              SubTab(
                  title: appLanguage().transfer_money,
                  icon: Assets.icons.transferMoney.keyName,
                  route: Routes.TRANSFER_MONEY
              ),
            if(module!.requestMoney!)
              SubTab(
                  title: appLanguage().request_money,
                  icon: Assets.icons.requestMoney.keyName,
                  route: Routes.REQUEST_MONEY
              ),
            SubTab(
                title: appLanguage().sent_requests,
                icon: Assets.icons.withdrawMoney.keyName,
                route: Routes.REQUEST_MONEY_LIST
            ),
            SubTab(
                title: appLanguage().received_requests,
                icon: Assets.icons.depositMpney.keyName,
                route: Routes.RECEIVED_REQUEST_LIST
            ),
          ]
      ),
      if(module!.exchangeMoney!)
        DrawerTab(
            title: appLanguage().exchange,
            tabs: [
              SubTab(
                  title: appLanguage().exchange,
                  icon: Assets.icons.exchangeMoney.keyName,
                  route: Routes.EXCHANGE_MONEY
              ),
            ]
        ),
      if(module!.makePayment!)
        DrawerTab(
            title: appLanguage().payment.toUpperCase(),
            tabs: [
              SubTab(
                  title: appLanguage().payment,
                  icon: Assets.icons.transferMoney.keyName,
                  route: Routes.MERCHANT_PAYMENT
              ),
            ]
        ),
      DrawerTab( //Done
          title: appLanguage().vouchers,
          tabs: [
            SubTab(
                title: appLanguage().my_vouchers,
                icon: Assets.icons.voucher.keyName,
                route: Routes.VOUCHER_LIST
            ),
            if(module!.createVoucher!)
              SubTab(
                  title: appLanguage().create_vouchers,
                  icon: Assets.icons.addVoucher.keyName,
                  route: Routes.CREATE_VOUCHER
              ),
            SubTab(
                title: appLanguage().redeem_vouchers,
                icon: Assets.icons.redeemVoucher.keyName,
                route: Routes.REDEEM_VOUCHER
            ),
            SubTab(
                title: appLanguage().redeemed_history,
                icon: Assets.icons.clock.keyName,
                route: Routes.REDEEM_HISTORY
            ),
          ]
      ),
      DrawerTab( //Done
        title: appLanguage().deposit,
        tabs: [
          if(module!.deposit!)
            SubTab(
                title: appLanguage().deposit,
                icon: Assets.icons.deposit.keyName,
                route: Routes.DEPOSIT_MONEY
            ),
          SubTab(
              title: appLanguage().deposit_history,
              icon: Assets.icons.clock.keyName,
              route: Routes.DEPOSIT_HISTORY
          ),
        ],
      ),
      DrawerTab( //Done
          title: appLanguage().withdraw,
          tabs: [
            if(module!.cashOut!)
              SubTab(
                  title: appLanguage().cashout_to_agent,
                  icon: Assets.icons.cashOut.keyName,
                  route: Routes.CASH_OUT
              ),
            if(module!.withdrawMoney!)
              SubTab(
                  title: appLanguage().withdraw_money,
                  icon: Assets.icons.withdraw.keyName,
                  route: Routes.ADD_WITHDRAW
              ),
            SubTab(
                title: appLanguage().withdraw_history,
                icon: Assets.icons.clock.keyName,
                route: Routes.WITHDRAW_LIST
            ),
          ]
      ),
      DrawerTab( //Done
          title: appLanguage().invoice,
          tabs: [
            SubTab(
                title: appLanguage().invoices,
                icon: Assets.icons.voucher.keyName,
                route: Routes.INVOICES
            ),
            if(module!.createInvoice!)
              SubTab(
                  title: appLanguage().create_invoice,
                  icon: Assets.icons.addVoucher.keyName,
                  route: Routes.CREATE_INVOICE
              ),
          ]
      ),
      DrawerTab( //Done
          title: appLanguage().escrow,
          tabs: [
            if(module!.makeEscrow!)
              SubTab(
                  title: appLanguage().make_escrow,
                  icon: Assets.icons.escrow.keyName,
                  route: Routes.CREATE_ESCROW
              ),
            SubTab(
                title: appLanguage().my_escrow,
                icon: Assets.icons.escrow.keyName,
                route: Routes.MY_ESCROW
            ),
            SubTab(
                title: appLanguage().pending_escrows,
                icon: Assets.icons.escrow.keyName,
                route: Routes.PENDING_ESCROW
            ),
          ]
      ),
      DrawerTab( //Done
          title: appLanguage().transactions,
          tabs: [
            SubTab(
                title: appLanguage().transactions,
                icon: Assets.icons.exchangeMoney.keyName,
                route: Routes.TRANSACTIONS
            ),
          ]
      ),
    ];
  }

  MainPageState init() {
    return MainPageState();
  }

  MainPageState clone({Dashboard? dashboard,PageState? pageState, User? user, Settings? settings}) {
    return MainPageState(
      dashboard: dashboard ?? this.dashboard,
      pageState: pageState ?? this.pageState,
      user: user ?? this.user,
      settings: settings ?? this.settings
    );
  }
}
