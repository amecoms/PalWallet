import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';


class EscrowConfirmationSheet extends StatelessWidget {
  final double amount,change;
  final String currency;
  const EscrowConfirmationSheet(this.amount, this.change, this.currency,{super.key});

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
                      '${appLanguage(context).preview} ${appLanguage(context).escrow}',
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textMedium
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLanguage(context).amount,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textMedium
                            ),
                          ),
                        ),
                        Text(
                          '${amount.toStringAsFixed(1)} $currency',
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
                            appLanguage(context).total_charge,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          '${change.toStringAsFixed(1)} $currency',
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
                            appLanguage(context).total_amount,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular
                            ),
                          ),
                        ),
                        Text(
                          '${(change+amount).toStringAsFixed(1)} $currency',
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
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        onTap: ()=> backPage(false),
                        padding: REdgeInsets.symmetric(vertical: 14),
                        buttonType: ButtonType.BORDER,
                        borderColor: AppColor.dividerColor,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(appLanguage(context).cancel,
                            style: appTheme(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 17.spMin,
                              fontWeight: Dimension.textSemiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: DefaultButton(
                        onTap: ()=> backPage(true),
                        padding: REdgeInsets.symmetric(vertical: 14),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(appLanguage(context).confirm,
                            style: appTheme(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 17.spMin,
                              fontWeight: Dimension.textSemiBold,
                              color: AppColor.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
