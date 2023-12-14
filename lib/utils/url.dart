class URL {
  static const String baseUrl = "https://palwallet.kasiwallet.online/";
  static const String googleAuthenticatorAppLinkAndroid =
      "https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en";
  static const String googleAuthenticatorAppLinkIos =
      "https://apps.apple.com/us/app/google-authenticator/id388497605";

  static const int paginate = 16;

  static const String signIn = '${baseUrl}api/user/login';
  static const String signUp = '${baseUrl}api/user/register';
  static const String refreshToken = '${baseUrl}api/user/refresh/token';
  static const String twoFaOtpVerification = '${baseUrl}api/user/otp-submit';
  static const String user = '${baseUrl}api/user/user-info';
  static const String updateProfile = '${baseUrl}api/user/profile-settings';
  static const String resetPassword = '${baseUrl}api/user/forgot-password';
  static const String verifyEmail =
      '${baseUrl}api/user/forgot-password/verify-code';
  static const String resetPasswordSubmit = '${baseUrl}api/user/reset-password';
  static const String changePassword = '${baseUrl}api/user/change-password';
  static const String kycForm = '${baseUrl}api/user/kyc-form-data';
  static const String kycFormSubmit = '${baseUrl}api/user/kyc-form';
  static const String generateQr = '${baseUrl}api/user/generate-qrcode';
  static const String settings = '${baseUrl}api/user/settings';
  static const String module = '${baseUrl}api/module';

  static const String dashboard = '${baseUrl}api/user/dashboard';

  //Deposit
  static const String depositFrom = '${baseUrl}api/user/deposit';
  static const String submitDeposit = '${baseUrl}api/user/deposit/submit';
  static const String depositGateways =
      '${baseUrl}api/user/gateway-methods?currency_id=';
  static const String depositHistory = '${baseUrl}api/user/deposit/history';

  //Invoice
  static const String invoice = '${baseUrl}api/user/create-invoice';
  static const String invoiceUpdate = '${baseUrl}api/user/invoices-update/';
  static const String invoiceSendEmail =
      '${baseUrl}api/user/invoice/send-mail/';
  static const String cancelInvoice = '${baseUrl}api/user/invoice-cancel/';
  static const String invoices = '${baseUrl}api/user/invoices';
  static const String invoiceDetails = '${baseUrl}api/user/invoice/view/';
  static const String changePaymentStatus =
      '${baseUrl}api/user/invoice/pay-status';
  static const String changePublishStatus =
      '${baseUrl}api/user/invoice/publish-status';

  //Escrow
  static const String escrowData = '${baseUrl}api/user/make-escrow';
  static const String myEscrow = '${baseUrl}api/user/my-escrow';
  static const String pendingEscrow = '${baseUrl}api/user/escrow-pending';
  static const String escrowDispute = '${baseUrl}api/user/escrow-dispute/';
  static const String escrowRelease = '${baseUrl}api/user/release-escrow/';

  //Transactions
  static String allTransactions(
          {String? remark, String? search, required int page}) =>
      '${baseUrl}api/user/transactions?remark=${remark ?? ''}&search=${search ?? ''}&page=$page';

  //Withdraw
  static const String withdrawList = '${baseUrl}api/user/withdraw-history';
  static const String withdrawFrom = '${baseUrl}api/user/withdraw-money';
  static const String methods = '${baseUrl}api/user/withdraw-methods?currency=';
  static const String submitWithdraw = '${baseUrl}api/user/withdraw-money';

  //Transaction
  static const String transferLog = '${baseUrl}api/user/transfer-money/history';
  static const String requestMoneyLog =
      '${baseUrl}api/user/sent-money-requests';
  static const String receivedRequestLog =
      '${baseUrl}api/user/received-money-requests';
  static const String transferMoneyFrom = '${baseUrl}api/user/transfer-money';
  static const String requestMoneyFrom = '${baseUrl}api/user/request-money';
  static const String acceptRequestMoney =
      '${baseUrl}api/user/accept-money-request';
  static const String rejectRequestMoney =
      '${baseUrl}api/user/reject-money-request';
  static const String checkReceiver = '${baseUrl}api/user/check-receiver';
  static const String submitTransfer = '${baseUrl}api/user/transfer-money';
  static const String submitRequest = '${baseUrl}api/user/request-money';

  //Exchange
  static const String exchangeData = '${baseUrl}api/user/exchange-money';
  static const String exchangeList =
      '${baseUrl}api/user/exchange-money/history';

  //Payment
  static const String paymentFrom = '${baseUrl}api/user/make-payment';
  static const String checkMerchant = '${baseUrl}api/user/check-merchant';
  static const String merchantPaymentHistory =
      '${baseUrl}api/user/payment/history';

  //Voucher
  static const String voucherData = '${baseUrl}api/user/create-voucher';
  static const String voucherList = '${baseUrl}api/user/vouchers';
  static const String redeemVoucherData = '${baseUrl}api/user/redeem-voucher';
  static const String redeemHistory = '${baseUrl}api/user/redeemed-history';

  // CashOut
  static const String cashOutFrom = '${baseUrl}api/user/cash-out';
  static const String agentCheck = '${baseUrl}api/user/check/agent';

  // Support
  static const String tickets = '${baseUrl}api/user/support/tickets';
  static const String openTickets = '${baseUrl}api/user/open/support/ticket';
  static const String ticketMessages =
      '${baseUrl}api/user/support/ticket/messages/';
  static const String ticketReply = '${baseUrl}api/user/reply/ticket/';

  //2fa verification
  static const String sendCode = '${baseUrl}api/user/send/two-step/verify-code';
  static const String resendCode =
      '${baseUrl}api/user/resend/two-step/verify-code';
  static const String enableVerification =
      '${baseUrl}api/user/two-step/verification';
  static const String loginVerification =
      '${baseUrl}api/user/two-step/code/verify';
}
