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

import '../../../../app_helper/helper.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/cashout_bloc.dart';
import '../bloc/cashout_event.dart';
import '../bloc/cashout_state.dart';
import '../data/cashout_form.dart';

class CashOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CashOutBloc()..add(InitEvent()),
      child: BlocBuilder<CashOutBloc, CashOutState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, CashOutState state) {
    final bloc = BlocProvider.of<CashOutBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).cashout_to_agent
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
                label: appLanguage(context).agent_email,
                hint: appLanguage(context).agent_email,
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
                  child: Text(appLanguage(context).valid_agent_found,style: appTheme(context).textTheme.bodyLarge!.copyWith(
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
                    appLanguage(context).cash_out,
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

  Widget amountView(CashOutBloc bloc, CashOutState state, BuildContext context) {
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

