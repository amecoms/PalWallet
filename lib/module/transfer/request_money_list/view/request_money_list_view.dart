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

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../../request_money/data/request_money.dart';
import '../bloc/request_money_list_bloc.dart';
import '../bloc/request_money_list_event.dart';
import '../bloc/request_money_list_state.dart';

class RequestMoneyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RequestMoneyListBloc()..add(InitEvent()),
      child: BlocBuilder<RequestMoneyListBloc,RequestMoneyListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, RequestMoneyListState state) {
    final bloc = BlocProvider.of<RequestMoneyListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).all_request
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.sentMoneyRequests!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.sentMoneyRequests!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              RequestMoney data = state.transfers!.response!.sentMoneyRequests!.data![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                color: AppColor.white,
                margin: REdgeInsets.only(bottom: 16,top: index == 0 ? 16 : 0),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                  tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
                  collapsedIconColor: AppColor.iconColor,
                  iconColor: AppColor.iconColor,
                  subtitle: Row(
                    children: [
                      Expanded(
                          child: Text(
                            appLanguage(context).recipient,
                            style: appTheme(context).textTheme.bodyLarge,
                          )
                      ),
                      Text(
                        data.receiver!.email ?? '',
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(color: AppColor.primary),
                      )
                    ],
                  ),
                  title: Row(
                    children: [
                      Expanded(
                          child: Text(
                            appLanguage(context).amount,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                          )
                      ),
                      Text(
                        '${(data.requestAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
                        style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                      )
                    ],
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              appLanguage(context).you_will_get.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                        ),
                        Text(
                          '${(data.finalAmount ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              appLanguage(context).state.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: data.status!.statusColor
                          ),
                          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            data.status!.statusName,
                            style: appTheme(context).textTheme.bodySmall
                          ),
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
                    8.verticalSpace
                  ],
                ),
              );
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }
}

