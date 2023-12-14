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
import 'package:genius_wallet/utils/design_component.dart';
import 'package:genius_wallet/utils/dimension.dart';

import '../../../../gen/assets.gen.dart';
import '../bloc/withdraw_money_bloc.dart';
import '../bloc/withdraw_money_event.dart';
import '../bloc/withdraw_money_state.dart';
import '../data/withdraw_from.dart';
import '../data/withdraw_method.dart';

class WithdrawMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WithdrawMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<WithdrawMoneyBloc, WithdrawMoneyState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, WithdrawMoneyState state) {
    final bloc = BlocProvider.of<WithdrawMoneyBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).withdraw_money
      ),
      body: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              amountView(bloc,state,context),
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
              if(state.methods!=null)
                DefaultDropDown<Methods>(
                  items: state.methods!.response!.methods!,
                  selectedItem: state.selectedMethods,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> a.name!,
                  label: appLanguage(context).method,
                  hint: appLanguage(context).select_method,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeMethods(value)),
                ),
              if(state.selectedWallets != null && state.selectedMethods!=null)
                ValueListenableBuilder<int>(
                    valueListenable: bloc.amountText,
                    builder: (context, value, child) {
                      double charge = ((state.selectedMethods!.fixedCharge!.toDouble * (state.selectedWallets!.currency!.rate!.toDouble)) + ((value / 100) * state.selectedMethods!.percentCharge!.toDouble));
                      double totalAmount = ((value * state.selectedWallets!.currency!.rate!.toDouble) / state.selectedWallets!.currency!.rate!.toDouble);
                      return Column(
                        children: [
                          16.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    appLanguage(context).total_charge,
                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),
                                  )
                              ),
                              Text(
                                '${charge.toStringAsFixed(1)} ${(state.selectedWallets!.currency!.code)}',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    appLanguage(context).total_amount,
                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),
                                  )
                              ),
                              Text(
                                '${(charge + totalAmount).toStringAsFixed(1)} ${(state.selectedWallets!.currency!.code)}',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                        ],
                      );
                    }
                ),
              16.verticalSpace,
              DefaultTextField(
                controller: bloc.accountDetails,
                label: appLanguage(context).account_details,
                hint: appLanguage(context).account_details_message,
                labelAsTitle: true,
                maxLine: 4,
              ),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.moneyFrom != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).confirm,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              Dimension.bottomSpace
            ],
          ),
        ),
      ),
    );
  }

  Widget amountView(WithdrawMoneyBloc bloc, WithdrawMoneyState state, BuildContext context) {
    String hintText = appLanguage(context).amount;
    String chargeText = '';
    num min = 0,max = 0;
    if(state.moneyFrom != null && state.selectedMethods != null){
      Wallets? dc = state.moneyFrom?.response?.wallets?.where((element) => (element.currency?.defaultValue ?? '0') == '1').first;
      min = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.selectedMethods!.minAmount!.toDouble) : state.selectedMethods!.minAmount!.toDouble;
      max = state.selectedWallets != null ? (state.selectedWallets!.currency!.rate!.toDouble * state.selectedMethods!.maxAmount!.toDouble) : state.selectedMethods!.maxAmount!.toDouble;
      hintText = '${appLanguage(context).min} : ${min.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code} -- ${appLanguage(context).max} : ${max.toStringAsFixed(0)} ${state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code}';
      chargeText = '${appLanguage(context).total_charge} : ${(state.selectedMethods!.fixedCharge!.toDouble * (state.selectedWallets != null ? state.selectedWallets!.currency!.rate!.toDouble : dc!.currency!.rate!.toDouble)).toStringAsFixed(0)} ${(state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code)} + ${state.selectedMethods!.percentCharge}%';
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

