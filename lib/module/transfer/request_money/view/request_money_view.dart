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

import '../../../../app_helper/helper.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/request_money_bloc.dart';
import '../bloc/request_money_event.dart';
import '../bloc/request_money_state.dart';
import '../data/request_money.dart' as RM;
import '../data/request_money_data.dart';

class RequestMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RequestMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<RequestMoneyBloc, RequestMoneyState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, RequestMoneyState state) {
    final bloc = BlocProvider.of<RequestMoneyBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).request_money
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
                enableScanEmail: true,
                textInputType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  child: Text(appLanguage(context).valid_receiver_found,style: appTheme(context).textTheme.bodyLarge!.copyWith(
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
              amountView(bloc,state,context),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.moneyFrom != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).transfer,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              16.verticalSpace,
              Text(
                appLanguage(context).recent_request,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              ListView.builder(
                itemCount: state.moneyFrom?.response?.recentRequests?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  RM.RequestMoney data = state.moneyFrom!.response!.recentRequests![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    color: AppColor.white,
                    margin: REdgeInsets.only(bottom: 16,top: index == 0 ? 16 : 0),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                      tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
                      collapsedIconColor: AppColor.iconColor,
                      iconColor: AppColor.iconColor,
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(
                                appLanguage(context).amount,
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                              )
                          ),
                          Text(
                            '${(data.requestAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                          )
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  appLanguage(context).you_will_get.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                            ),
                            Text(
                              '${(data.finalAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  appLanguage(context).state.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: data.status!.statusColor
                              ),
                              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              child: Text(
                                data.status!.statusName,
                                style: appTheme(context).textTheme.bodySmall
                              ),
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  appLanguage(context).date.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                            ),
                            Text(
                              DateFormat('dd MMM yyyy -- hh:mm a').format(DateTime.parse(data.createdAt ?? '')),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                        8.verticalSpace
                      ],
                    ),
                  );
                }
              ),
              16.verticalSpace,
              Center(
                child: DefaultButton(
                    onTap: ()=> goToPage(Routes.REQUEST_MONEY_LIST),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).all_request,
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

  Widget amountView(RequestMoneyBloc bloc, RequestMoneyState state, BuildContext context) {
    String hintText = appLanguage(context).amount;
    String chargeText = '';
    num min = 0,max = 0;
    if(state.moneyFrom != null){
      Currency? dc = state.moneyFrom?.response?.currency?.where((element) => (element.defaultValue ?? '0') == '1').first;
      min = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.moneyFrom!.response!.charge!.minimum!.toDouble) : state.moneyFrom!.response!.charge!.minimum!.toDouble;
      max = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.moneyFrom!.response!.charge!.maximum!.toDouble) : state.moneyFrom!.response!.charge!.maximum!.toDouble;
      hintText = '${appLanguage(context).min} : ${min.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.code} -- ${appLanguage(context).max} : ${max.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.code}';
      chargeText = '${appLanguage(context).total_charge} : ${(state.moneyFrom!.response!.charge!.fixedCharge!.toDouble * (state.selectedWallets != null ? state.selectedWallets!.currency!.rate!.toDouble : dc!.rate!.toDouble)).toStringAsFixed(0)} ${(state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.code)} + ${state.moneyFrom!.response!.charge!.percentCharge}%';
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

