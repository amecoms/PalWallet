import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/empty_page.dart';
import 'package:genius_wallet/Widgets/swipe_refresh.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/divider_list.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/payment_list_bloc.dart';
import '../bloc/payment_list_event.dart';
import '../bloc/payment_list_state.dart';
import '../data/payment_history.dart';

class PaymentHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PaymentHistoryBloc()..add(InitEvent()),
      child: BlocBuilder<PaymentHistoryBloc,PaymentHistoryState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, PaymentHistoryState state) {
    final bloc = BlocProvider.of<PaymentHistoryBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).payment_history
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.payments!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.payments!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              PaymentData data = state.transfers!.response!.payments!.data![index];
              return singlePayment(data);
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }

  Widget singlePayment(PaymentData data) {
    return DividerList(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: appTheme().textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textMedium
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    (data.details ?? '').split(':').last.trim(),
                    style: appTheme().textTheme.bodyMedium,
                  ),
                  4.verticalSpace,
                  Text(
                    DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.createdAt ?? '')),
                    style: appTheme().textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${data.type} ${(data.amount ?? '').toDouble.toStringAsFixed(2)}',
                  style: appTheme().textTheme.headlineLarge!.copyWith(
                      fontWeight: Dimension.textMedium,
                      color: data.type == '-' ? AppColor.red : AppColor.green
                  ),
                ),
                4.verticalSpace,
                Text(
                  data.trnx ?? '',
                  style: appTheme().textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

