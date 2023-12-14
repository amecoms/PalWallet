import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/module/transfer/transfer_money/data/transfer_log.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/divider_list.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/design_component.dart';
import '../../../../utils/dimension.dart';
import '../../../main_page/data/dashboard.dart';
import '../../../main_page/view/transaction_details_sheet.dart';

class SingleTransfer extends StatelessWidget {
  final TransferData data;
  const SingleTransfer(this.data,{super.key});

  @override
  Widget build(BuildContext context) {
    return DividerList(
      child: InkWell(
        onTap: ()=> showTransactionDetails(),
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.2),
                    shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: Assets.icons.transferMoney.svg(height: 20.h, color: AppColor.iconColor),
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (data.remark ?? '').replaceAll('_', ' ').capitalize,
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: Dimension.textMedium
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      data.trnx ?? '',
                      style: appTheme(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${data.type} ${(data.amount ?? '').toDouble.toStringAsFixed(2)}',
                    style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textMedium,
                        color: data.type == '-' ? AppColor.red : AppColor.green
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.createdAt ?? '')),
                    style: appTheme(context).textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showTransactionDetails(){
    DesignComponent.showBottomSheetPopup(child: TransactionDetailsSheet(TransactionData.fromJson(data.toJson())));
  }
}
