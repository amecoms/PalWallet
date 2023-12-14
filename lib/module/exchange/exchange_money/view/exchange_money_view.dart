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
import '../bloc/exchange_money_bloc.dart';
import '../bloc/exchange_money_event.dart';
import '../bloc/exchange_money_state.dart';
import '../data/exchange_data.dart';

class ExchangeMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExchangeMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<ExchangeMoneyBloc, ExchangeMoneyState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, ExchangeMoneyState state) {
    final bloc = BlocProvider.of<ExchangeMoneyBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).exchange_money
      ),
      body: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              if(state.exchangeData != null)
                DefaultDropDown<Wallets>(
                  items: state.exchangeData!.response!.wallets!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> '${a.currency!.code}',
                  label: appLanguage(context).from_currency,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeWallets(value)),
                ),
              16.verticalSpace,
              if(state.exchangeData != null)
                DefaultDropDown<Currencies>(
                  items: state.exchangeData!.response!.currencies!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> '${a.code}',
                  label: appLanguage(context).to_currency,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeToWallets(value)),
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
                ],
              ),
              if(state.selectedWallets != null && state.selectedToWallets!=null)
                ValueListenableBuilder<int>(
                  valueListenable: bloc.amountText,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        16.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  appLanguage(context).exchange_charge,
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                            ),
                            Text(
                              '${((state.exchangeData!.response!.charge!.fixedCharge!.toDouble * (state.selectedWallets!.currency!.rate!.toDouble)) + ((value / 100) * state.exchangeData!.response!.charge!.percentCharge!.toDouble)).toStringAsFixed(6)} ${(state.selectedWallets!.currency!.code)}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  appLanguage(context).will_get,
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                            ),
                            Text(
                              '${((value * state.selectedToWallets!.rate!.toDouble) / state.selectedWallets!.currency!.rate!.toDouble).toStringAsFixed(6)} ${(state.selectedToWallets!.code)}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                ),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.exchangeData != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).exchange,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              16.verticalSpace,
              Text(
                appLanguage(context).recent_exchanges,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              16.verticalSpace,
              ListView.builder(
                itemCount: state.exchangeData?.response?.recentExchanges?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  RecentExchanges data = state.exchangeData!.response!.recentExchanges![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    color: AppColor.white,
                    margin: REdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                      tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
                      collapsedIconColor: AppColor.iconColor,
                      iconColor: AppColor.iconColor,
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${data.fromCurr!.code} to ${data.toCurr!.code}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                            )
                          ),
                          Text(
                            '${(data.toAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.toCurr!.code}',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                          )
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                appLanguage(context).from_currency.toUpperCase(),
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ),
                            Text(
                              '${(data.fromAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.fromCurr!.code}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                appLanguage(context).to_currency.toUpperCase(),
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ),
                            Text(
                              '${(data.toAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.toCurr!.code}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                appLanguage(context).charge.toUpperCase(),
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ),
                            Text(
                              '${(data.charge ?? '0').toDouble.toStringAsFixed(1)} ${data.fromCurr!.code}',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
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
                      ],
                    ),
                  );
                }
              ),
              16.verticalSpace,
              Center(
                child: DefaultButton(
                    onTap: ()=> goToPage(Routes.EXCHANGE_LIST),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).all_exchanges,
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

}

