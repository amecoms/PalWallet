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
import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/divider_list.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/deposit_money_bloc.dart';
import '../bloc/deposit_money_event.dart';
import '../bloc/deposit_money_state.dart';
import '../data/deposit_from.dart';

class DepositMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DepositMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<DepositMoneyBloc, DepositMoneyState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, DepositMoneyState state) {
    final bloc = BlocProvider.of<DepositMoneyBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).deposit
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
                  controller: bloc.amount,
                  label: appLanguage(context).amount,
                  hint: appLanguage(context).amount,
                  labelAsTitle: true,
                  textInputType: const TextInputType.numberWithOptions(decimal: true,),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
              ),
              16.verticalSpace,
              if(state.moneyFrom != null)
                DefaultDropDown<Wallets>(
                  items: state.moneyFrom!.response!.wallets!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> a.code!,
                  label: appLanguage(context).select_wallet,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeWallets(value)),
                ),
              16.verticalSpace,
              if(state.gateways != null)
                DefaultDropDown<Methods>(
                  items: state.gateways!.response!.methods!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> a.name!,
                  label: appLanguage(context).select_gateway,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeMethod(value)),
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
              16.verticalSpace,
              Text(
                appLanguage(context).recent_deposits,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              12.verticalSpace,
              ListView.builder(
                itemCount: state.moneyFrom?.response?.recentDeposits?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  RecentDeposits data = state.moneyFrom!.response!.recentDeposits![index];
                  return singleDeposit(data);
                }
              ),
              16.verticalSpace,
              Center(
                child: DefaultButton(
                    onTap: ()=> goToPage(Routes.DEPOSIT_HISTORY),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).all_deposit,
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

  Widget singleDeposit(RecentDeposits data) {
    return Card(
      margin: REdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: data.status!.statusColor
              ),
              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                  data.status!.statusName,
                  style: appTheme().textTheme.bodySmall
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.txnId ?? '',
                    style: appTheme().textTheme.headlineLarge!.copyWith(
                      fontWeight: Dimension.textMedium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Text(
                    DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.createdAt ?? '')),
                    style: appTheme().textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(data.amount ?? '').toDouble.toStringAsFixed(2)} ${data.currency!.code}',
                  style: appTheme().textTheme.bodyLarge!.copyWith(
                    fontWeight: Dimension.textMedium,
                  ),
                ),
                4.verticalSpace,
                if(data.charge != null)
                Text(
                  '${appLanguage().charge} ${(data.charge ?? '0').toString().toDouble.toStringAsFixed(2)} ${data.currency!.code}',
                  style: appTheme().textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

