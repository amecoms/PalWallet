import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/default_dropdown.dart';
import 'package:genius_wallet/Widgets/default_textfield.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/module/transfer/transfer_money/data/transfer_log.dart';
import 'package:genius_wallet/module/transfer/transfer_money/view/single_transfer.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/design_component.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/divider_list.dart';
import '../../../../app_helper/helper.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/merchant_payment_bloc.dart';
import '../bloc/merchant_payment_event.dart';
import '../bloc/merchant_payment_state.dart';
import '../data/payment_from.dart';

class MerchantPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MerchantPaymentBloc()..add(InitEvent()),
      child: BlocBuilder<MerchantPaymentBloc, MerchantPaymentState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, MerchantPaymentState state) {
    final bloc = BlocProvider.of<MerchantPaymentBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).payment
      ),
      body: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              DefaultTextField(
                controller: bloc.receiverEmail,
                label: appLanguage(context).receiver_email,
                hint: appLanguage(context).enter_receiver_email,
                labelAsTitle: true,
                textInputType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableScanEmail: true,
                validator: (value){
                  if(value == null || (value??'').isEmpty){
                    return '${appLanguage(context).receiver_email}${appLanguage(context).required}';
                  } else if(state.receiverCheck != null && !state.receiverCheck!.success!){
                    return state.receiverCheck!.response![0];
                  } else if(!Helper.isEmailValid(value ?? '')){
                    return appLanguage(context).enter_valid_email;
                  }
                  return null;
                },
              ),
              if(state.receiverCheck != null && state.receiverCheck!.success!)
                RPadding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(appLanguage(context).valid_merchant_found,style: appTheme(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.green
                  ),),
                ),
              16.verticalSpace,
              if(state.moneyFrom != null)
                DefaultDropDown<Wallets>(
                  items: state.moneyFrom!.response!.wallets!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> '${a.currency!.code} -- (${a.balance!.toDouble.toStringAsFixed(2)})',
                  label: appLanguage(context).select_wallet,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeWallets(value)),
                ),
              16.verticalSpace,
              DefaultTextField(
                controller: bloc.amount,
                label: appLanguage(context).amount,
                hint: appLanguage(context).amount,
                labelAsTitle: true,
                textInputType: const TextInputType.numberWithOptions(decimal: true,),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ]
              ),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.moneyFrom != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).make_payment,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              16.verticalSpace,
              Text(
                appLanguage(context).recent_payments,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              ListView.builder(
                itemCount: state.moneyFrom?.response?.recentPayments?.data?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  PaymentData data = state.moneyFrom!.response!.recentPayments!.data![index];
                  return singlePayment(data);
                }
              ),
              16.verticalSpace,
              Center(
                child: DefaultButton(
                    onTap: ()=> goToPage(Routes.PAYMENT_HISTORY),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).all_payment,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textRegular,
                            color: AppColor.primary
                          ),
                        ),
                        8.horizontalSpace,
                        Assets.icons.forword.svg(),
                      ],
                    )
                ),
              ),
              Dimension.bottomSpace
            ],
          ),
        ),
      ),
    );
  }

  Widget singlePayment(PaymentData data) {
    return DividerList(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.2),
                  shape: BoxShape.circle
              ),
              alignment: Alignment.center,
              child: Assets.icons.transferMoney.svg(height: 20.h, color: AppColor.iconColor),
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (data.remark ?? '').replaceAll('_', ' ').capitalize,
                    style: appTheme().textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textMedium
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    (data.details ?? '').split(':').last.trim(),
                    style: appTheme().textTheme.bodyMedium,
                  ),
                  4.verticalSpace,
                  Text(
                    DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.createdAt ?? '')),
                    style: appTheme().textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${data.type} ${(data.amount ?? '').toDouble.toStringAsFixed(2)}',
                  style: appTheme().textTheme.headlineLarge!.copyWith(
                      fontWeight: Dimension.textMedium,
                      color: data.type == '-' ? AppColor.red : AppColor.green
                  ),
                ),
                4.verticalSpace,
                Text(
                  data.trnx ?? '',
                  style: appTheme().textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

