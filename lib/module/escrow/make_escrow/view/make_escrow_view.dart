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
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/dimension.dart';

import '../../../../app_helper/helper.dart';
import '../bloc/make_escrow_bloc.dart';
import '../bloc/make_escrow_event.dart';
import '../bloc/make_escrow_state.dart';
import '../data/excrow_data.dart';

class MakeEscrowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MakeEscrowBloc()..add(InitEvent()),
      child: BlocBuilder<MakeEscrowBloc, MakeEscrowState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, MakeEscrowState state) {
    final bloc = BlocProvider.of<MakeEscrowBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).make_escrow
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
                label: appLanguage(context).recipient_email,
                hint: appLanguage(context).recipient_email,
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
                  child: Text(appLanguage(context).valid_recipient_found,style: appTheme(context).textTheme.bodyLarge!.copyWith(
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
              16.verticalSpace,
              DefaultTextField(
                controller: bloc.description,
                label: appLanguage(context).description,
                hint: appLanguage(context).type_here,
                labelAsTitle: true,
                maxLine: 4,
                textInputType: TextInputType.emailAddress,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bloc.chargePay,
                builder: (context, value, child) {
                  return CheckboxListTile(
                    value: value,
                    activeColor: AppColor.primary,
                    title: Text(
                      appLanguage(context).i_will_pay_the_charge,
                      style: appTheme(context).textTheme.bodyLarge,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (v){
                      bloc.chargePay.value = v ?? false;
                    },
                  );
                }
              ),
              16.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.moneyFrom != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).submit,
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

  Widget amountView(MakeEscrowBloc bloc, MakeEscrowState state, BuildContext context) {
    String hintText = appLanguage(context).amount;
    String chargeText = '';
    if(state.moneyFrom != null){
      Wallets? dc = state.moneyFrom?.response?.wallets?.where((element) => (element.currency?.defaultValue ?? '0') == '1').first;
      chargeText = '${appLanguage(context).total_charge} : ${(state.moneyFrom!.response!.charge!.fixedCharge!.toDouble * (state.selectedWallets != null ? state.selectedWallets!.currency!.rate!.toDouble : dc!.currency!.rate!.toDouble)).toStringAsFixed(0)} ${(state.selectedWallets != null ? state.selectedWallets!.currency!.code : dc!.currency!.code)} + ${state.moneyFrom!.response!.charge!.percentCharge}%';
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

