import 'package:flutter/material.dart';
import 'package:genius_wallet/module/deposit/deposit_money/view/deposit_money_view.dart';
import '../module/change_password/change_password_view.dart';
import '../module/contact_us/contact_us_view.dart';
import '../module/deposit/deposit_history/view/deposit_history_view.dart';
import '../module/escrow/escrow_dispute/view/escrow_dispute_view.dart';
import '../module/escrow/make_escrow/view/make_escrow_view.dart';
import '../module/escrow/my_escrow/view/my_escrow_view.dart';
import '../module/escrow/pending_escrow/view/pending_escrow_view.dart';
import '../module/exchange/exchange_list/view/exchange_list_view.dart';
import '../module/exchange/exchange_money/view/exchange_money_view.dart';
import '../module/invoice/create_invoice/view/create_invoice_view.dart';
import '../module/invoice/invoice_list/view/invoice_list_view.dart';
import '../module/my_profile/my_profile_view.dart';
import '../module/payment/merchant_payment/view/merchant_payment_view.dart';
import '../module/payment/payment_list/view/payment_list_view.dart';
import '../module/payment_page/payment_page_view.dart';
import '../module/qr_code/qr_code_view.dart';
import '../module/qr_scanner/qr_scanner_view.dart';
import '../module/reset_password/view/reset_password_view.dart';
import '../module/settings/settings_view.dart';
import '../module/sign_in/view/sign_in_view.dart';
import '../module/sign_up/view/sign_up_view.dart';
import '../module/splash/splash_view.dart';
import '../module/kyc_verification/view/kyc_verification_view.dart';
import '../module/main_page/view/main_page_view.dart';
import '../module/support/support_details/view/support_details_view.dart';
import '../module/support/support_list/view/support_list_view.dart';
import '../module/transactions/transaction_list/view/transaction_list_view.dart';
import '../module/transfer/received_request_list/view/received_request_list_view.dart';
import '../module/transfer/request_money/view/request_money_view.dart';
import '../module/transfer/request_money_list/view/request_money_list_view.dart';
import '../module/transfer/transfer_list/view/transfer_list_view.dart';
import '../module/transfer/transfer_money/view/transfer_money_view.dart';
import '../module/two_fa_verification/view/two_fa_verification_view.dart';
import '../module/voucher/create_voucher/view/create_voucher_view.dart';
import '../module/voucher/redeem_history/view/redeem_history_view.dart';
import '../module/voucher/reedem_voucher/view/reedem_voucher_view.dart';
import '../module/voucher/voucher_list/view/voucher_list_view.dart';
import '../module/withdraw/cashout/view/cashout_view.dart';
import '../module/withdraw/withdraw_history/view/withdraw_history_view.dart';
import '../module/withdraw/withdraw_money/view/withdraw_money_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static Map<String, WidgetBuilder> routes = {
    INITIAL : (context) => SplashPage(),
    Routes.SIGN_IN : (context) => SignInPage(),
    Routes.SIGN_UP : (context) => SignUpPage(),
    Routes.KYC_VERIFICATION : (context) => KycVerificationPage(),
    Routes.MAIN_PAGE : (context) => MainPage(),
    Routes.EDIT_PROFILE : (context) => MyProfilePage(),
    Routes.CHANGE_PASSWORD : (context) => ChangePasswordPage(),
    Routes.RESET_PASSWORD : (context) => ResetPasswordPage(),
    Routes.SETTINGS : (context) => SettingsPage(),
    Routes.CONTACT_US : (context) => ContactUsPage(),
    Routes.DEPOSIT_MONEY : (context) => DepositMoneyPage(),
    Routes.DEPOSIT_HISTORY : (context) => DepositHistoryPage(),
    Routes.WITHDRAW_LIST : (context) => WithdrawHistoryPage(),
    Routes.ADD_WITHDRAW : (context) => WithdrawMoneyPage(),
    Routes.TRANSFER_LOG : (context) => TransferListPage(),
    Routes.PAYMENT_PAGE : (context) => PaymentPagePage(),
    Routes.TWO_FA_VERIFICATION : (context) => TwoFAVerificationPage(),
    Routes.TRANSFER_MONEY : (context) => TransferMoneyPage(),
    Routes.REQUEST_MONEY : (context) => RequestMoneyPage(),
    Routes.REQUEST_MONEY_LIST : (context) => RequestMoneyListPage(),
    Routes.RECEIVED_REQUEST_LIST : (context) => ReceivedRequestListPage(),
    Routes.EXCHANGE_MONEY : (context) => ExchangeMoneyPage(),
    Routes.EXCHANGE_LIST : (context) => ExchangeListPage(),
    Routes.CREATE_VOUCHER : (context) => CreateVoucherPage(),
    Routes.VOUCHER_LIST : (context) => VoucherListPage(),
    Routes.REDEEM_VOUCHER : (context) => ReedemVoucherPage(),
    Routes.REDEEM_HISTORY : (context) => RedeemHistoryPage(),
    Routes.MERCHANT_PAYMENT : (context) => MerchantPaymentPage(),
    Routes.PAYMENT_HISTORY : (context) => PaymentHistoryPage(),
    Routes.CREATE_INVOICE : (context) => CreateInvoicePage(),
    Routes.INVOICES : (context) => InvoiceListPage(),
    Routes.CREATE_ESCROW : (context) => MakeEscrowPage(),
    Routes.MY_ESCROW : (context) => MyEscrowPage(),
    Routes.PENDING_ESCROW : (context) => PendingEscrowPage(),
    Routes.MY_ESCROW_DISPUTE : (context) => EscrowDisputePage(),
    Routes.TRANSACTIONS : (context) => TransactionListPage(),
    Routes.CASH_OUT : (context) => CashOutPage(),
    Routes.SUPPORT_PAGES : (context) => SupportListPage(),
    Routes.SUPPORT_DETAILS : (context) => SupportDetailsPage(),
    Routes.QR_PAGE : (context) => QrCodePage(),
    Routes.QR_SCANNER_PAGE : (context) => QrScannerPage(),
  };
}
