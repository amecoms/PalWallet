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
import 'package:genius_wallet/module/deposit/deposit_money/data/deposit_from.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/deposit_history_bloc.dart';
import '../bloc/deposit_history_event.dart';
import '../bloc/deposit_history_state.dart';

class DepositHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DepositHistoryBloc()..add(InitEvent()),
      child: BlocBuilder<DepositHistoryBloc,DepositHistoryState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, DepositHistoryState state) {
    final bloc = BlocProvider.of<DepositHistoryBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).deposit_history
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.deposits!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.deposits!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              RecentDeposits data = state.transfers!.response!.deposits!.data![index];
              return singleDeposit(data);
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
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

