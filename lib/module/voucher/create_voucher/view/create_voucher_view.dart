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
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../bloc/create_voucher_bloc.dart';
import '../bloc/create_voucher_event.dart';
import '../bloc/create_voucher_state.dart';
import '../data/voucher_data.dart';

class CreateVoucherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateVoucherBloc()..add(InitEvent()),
      child: BlocBuilder<CreateVoucherBloc, CreateVoucherState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, CreateVoucherState state) {
    final bloc = BlocProvider.of<CreateVoucherBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).create_vouchers
      ),
      body: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              if(state.voucherData != null)
                DefaultDropDown<Wallets>(
                  items: state.voucherData!.response!.wallets!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> '${a.currency!.code} -- (${a.balance!.toDouble.toStringAsFixed(2)})',
                  label: appLanguage(context).select_wallet,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeWallets(value)),
                ),
              16.verticalSpace,
              amountView(bloc,state,context),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.voucherData != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).create,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              16.verticalSpace,
              Text(
                appLanguage(context).recent_transfers,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              16.verticalSpace,
              ListView.builder(
                itemCount: state.voucherData?.response?.recentVouchers?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  RecentVouchers data = state.voucherData!.response!.recentVouchers![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    margin: REdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: REdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    data.code ?? '',
                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                                  )
                              ),
                              Text(
                                '${(data.amount ?? '0').toDouble.toStringAsFixed(0)} ${data.currency!.code}',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    DateFormat('dd MMM yyyy -- hh:mm a').format(DateTime.parse(data.createdAt ?? '')),
                                    style: appTheme(context).textTheme.bodyMedium,
                                  )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: data.status! == '0' ? AppColor.textColor : AppColor.green
                                ),
                                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                child: Text(
                                  data.status! == '0' ? appLanguage().unused : appLanguage(context).used,
                                  style: appTheme(context).textTheme.bodySmall!.copyWith(
                                    color: AppColor.white
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
              16.verticalSpace,
              Center(
                child: DefaultButton(
                    onTap: ()=> goToPage(Routes.VOUCHER_LIST),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).all_vouchers,
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

  Widget amountView(CreateVoucherBloc bloc, CreateVoucherState state, BuildContext context) {
    String hintText = appLanguage(context).amount;
    String chargeText = '';
    num min = 0,max = 0;
    if(state.voucherData != null){
      Wallets? dc = state.voucherData?.response?.wallets?.where((element) => (element.currency?.defaultValue ?? '0') == '1').first;
      min = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.voucherData!.response!.charge!.minimum!.toDouble) : state.voucherData!.response!.charge!.minimum!.toDouble;
      max = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.voucherData!.response!.charge!.maximum!.toDouble) : state.voucherData!.response!.charge!.maximum!.toDouble;
      hintText = '${appLanguage(context).min} : ${min.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code} -- ${appLanguage(context).max} : ${max.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code}';
      chargeText = '${appLanguage(context).total_charge} : ${(state.voucherData!.response!.charge!.fixedCharge!.toDouble * (state.selectedWallets != null ? state.selectedWallets!.currency!.rate!.toDouble : dc!.currency!.rate!.toDouble)).toStringAsFixed(0)} ${(state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code)} + ${state.voucherData!.response!.charge!.percentCharge}%';
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextField(
          controller: bloc.amount,
          label: appLanguage(context).amount != hintText ? '${appLanguage(context).amount}: ($hintText)' : hintText,
          hint: hintText,
          labelAsTitle: true,
          textInputType: const TextInputType.numberWithOptions(decimal: true,),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value){
            if(value == null || (value??'').isEmpty){
              return '${appLanguage(context).amount}${appLanguage(context).required}';
            } else if(value.toDouble < min || value.toDouble > max){
              return appLanguage(context).please_follow_the_limit;
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        if(chargeText.isNotEmpty)
          RPadding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(chargeText,style: appTheme(context).textTheme.bodyLarge!.copyWith(
              color: AppColor.primary
            ),),
          )
      ],
    );
  }
}

