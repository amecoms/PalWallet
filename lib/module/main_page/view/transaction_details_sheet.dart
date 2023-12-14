import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:intl/intl.dart';

import '../../../Widgets/default_button.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../data/dashboard.dart';

class TransactionDetailsSheet extends StatelessWidget {
  final TransactionData data;
  const TransactionDetailsSheet(this.data,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20.r),
          topStart: Radius.circular(20.r),
        ),
        color: AppColor.white,
      ),
      padding: REdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              32.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Assets.icons.info.svg(height: 32.h),
                    4.verticalSpace,
                    Text(
                      appLanguage(context).transaction_details,
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textMedium
                      ),
                    ),
                    Text(
                      data.details ?? '',
                      style: appTheme(context).textTheme.bodyLarge
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).transaction_id,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textMedium
                            ),
                          ),
                        ),
                        Text(
                          data.trnx ?? '',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textRegular
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).remark,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          (data.remark ?? '').replaceAll('_', ' ').capitalize,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textRegular
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).currency,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          data.currency?.code ?? '',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textRegular
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).amount,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          '${data.type ?? ''} ${data.currency!.symbol}${(data.amount ?? '0').toDouble.toStringAsFixed(2)}',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textRegular,
                            color: data.type == '-' ? AppColor.red : AppColor.green
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).charge,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          (data.charge ?? '0').toDouble.toStringAsFixed(2),
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).date,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.createdAt ?? '')),
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                  ],
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: DefaultButton(
                  onTap: ()=> backPage(),
                  padding: REdgeInsets.symmetric(vertical: 14),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(appLanguage(context).close,
                      style: appTheme(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 17.spMin,
                          fontWeight: Dimension.textSemiBold,
                          color: AppColor.white
                      ),
                    ),
                  ),
                ),
              ),
              Dimension.bottomSpace
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
                onPressed: () => backPage(),
                icon: Icon(Icons.close_rounded,
                    color: AppColor.iconColor)),
          )
        ],
      ),
    );
  }
}
