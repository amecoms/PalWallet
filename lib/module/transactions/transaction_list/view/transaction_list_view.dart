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
import '../../../../utils/design_component.dart';
import '../../../../utils/dimension.dart';
import '../../../main_page/data/dashboard.dart';
import '../../../main_page/view/transaction_details_sheet.dart';
import '../bloc/transaction_list_bloc.dart';
import '../bloc/transaction_list_event.dart';
import '../bloc/transaction_list_state.dart';
import 'filter_sheet.dart';

class TransactionListPage extends StatelessWidget {
  TransactionListBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TransactionListBloc()..add(InitEvent()),
      child: BlocBuilder<TransactionListBloc,TransactionListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TransactionListState state) {
    bloc ??= BlocProvider.of<TransactionListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).transactions,
        actions: [
          IconButton(
            onPressed: ()=> showFilter(),
            icon: Icon(Icons.filter_list_rounded, color: AppColor.white,)
          )
        ]
      ),
      body: SwipeRefresh(
        controller: bloc!.refreshController,
        onRefresh: (){
          bloc!.add(InitEvent());
          bloc!.add(GetData());
        },
        onLoading: ()=>bloc!.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 0.8.sh) : state.transfers!.response!.transactions!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.transactions!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              TransactionData data = state.transfers!.response!.transactions!.data![index];
              return DividerList(
                child: InkWell(
                  onTap: ()=> showTransactionDetails(data),
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
                          child: data.remark!.getIcon(),
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
                              '${data.type ?? ''} ${data.currency!.symbol}${(data.amount ?? '').toDouble.toStringAsFixed(2)}',
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
        ) : bloc!.refreshController.isRefresh ? CircularProgress(height: 0.8.sh) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }

  void showTransactionDetails(TransactionData data){
    DesignComponent.showBottomSheetPopup(child: TransactionDetailsSheet(data));
  }
  void showFilter(){
    if(bloc!.state.transfers==null) return;
    DesignComponent.showBottomSheetPopup(
      isScrollControlled: true,
      child: FilterSheet(bloc!)
    );
  }
}

