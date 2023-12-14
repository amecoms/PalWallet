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
import '../bloc/reedem_voucher_bloc.dart';
import '../bloc/reedem_voucher_event.dart';
import '../bloc/reedem_voucher_state.dart';
import '../data/voucher_data.dart';

class ReedemVoucherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ReedemVoucherBloc()..add(InitEvent()),
      child: BlocBuilder<ReedemVoucherBloc, ReedemVoucherState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, ReedemVoucherState state) {
    final bloc = BlocProvider.of<ReedemVoucherBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).redeem_vouchers
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
                controller: bloc.code,
                label: appLanguage(context).voucher_code,
                hint: appLanguage(context).voucher_code,
                labelAsTitle: true,
              ),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.voucherData != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    appLanguage(context).redeem,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              16.verticalSpace,
              Text(
                appLanguage(context).recent_redeemed_vouchers,
                style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 24.spMin
                ),
              ),
              16.verticalSpace,
              ListView.builder(
                itemCount: state.voucherData?.response?.recentRedeemed?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx,index){
                  RecentRedeemed data = state.voucherData!.response!.recentRedeemed![index];
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
                                '${(data.code ?? '0').toDouble.toStringAsFixed(0)} ${data.currency!.code}',
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
                    onTap: ()=> goToPage(Routes.REDEEM_HISTORY),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLanguage(context).redeem_history,
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

