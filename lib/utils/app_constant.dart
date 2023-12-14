import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';
class AppConstant{
  static String AppName='Genius Bank';
  static String Share_Auth='auth';
  static String Share_Language='language';
  static String Share_Theme='theme';
  static String Share_Credential='credentials';
  static String Error='error';
  static String Unauthenticated='Unauthenticated.';
  static String Android='android';
  static String iOS='ios';
  static String Default_Language='fr';
  static String Default_Currency='\$';
  static Size defaultScreenSize = const Size(375, 720);
  static int AnimationDelay=375;
  static DateFormat defaultDateFormat=DateFormat("yyyy-MM-dd");
  static const PhoneNumber defaultPhoneNumber = PhoneNumber(isoCode: IsoCode.BD,nsn: '');

  static const String success = 'success';

  static const String email='email';
  static const String password='password';

  static const fullname='fullname';
  static const phone='phone';
  static const address='address';

  static const id = 'id';

  static const user_id='user_id';

  static const total = 'total';
  static const name = 'name';
  static const fax = 'fax';
  static const zip = 'zip';
  static const city = 'city';
  static const country = 'country';
  static const current_password = 'current_password';
  static const new_password = 'new_password';
  static const confirm_password = 'confirm_password';
  static const renew_password = 'renew_password';
  static const reset_token = 'reset_token';
  static const message = 'message';

  static const error='error';

  static const data='data';
  static const search='search';

  static const url = 'url';

  static const Completed='Completed';
  static const currency_code='currency_code';
  static const amount='amount';
  static const planId='planId';

  static var bank_plan_id='bank_plan_id';

  static var plan_data= 'plan_data';

  static var plan_id='plan_id';

  static var total_installment='total_installment';

  static var loan_amount='loan_amount';

  static var per_installment_amount='per_installment_amount';

  static var total_amount='total_amount';

  static var page='page';

  static var dps_plan_id='dps_plan_id';
  static var per_installment='per_installment';
  static var deposit_amount='deposit_amount';
  static var matured_amount='matured_amount';

  static var wire_transfer_bank_id='wire_transfer_bank_id';
  static var swift_code='swift_code';
  static var currency='currency';
  static var routing_number='routing_number';
  static var account_number='account_number';
  static var account_name='account_name';
  static var account_holder_name='account_holder_name';
  static var note='note';

  static var method='method';

  static var currency_id='currency_id';

  static var details='details';

  static var other_bank_id='other_bank_id';
  static var nick_name='nick_name';

  static var fdr_amount='fdr_amount';
  static var profit_amount='profit_amount';

  static var subject='subject';

  static var conversation_id='conversation_id';

  static var beneficiary_id='beneficiary_id';
  static var bank_name='bank_name';

  static var key='key';
  static var code='code';

  static var otp='otp';

  static var password_confirmation='password_confirmation';

  static var dial_code='dial_code';
}