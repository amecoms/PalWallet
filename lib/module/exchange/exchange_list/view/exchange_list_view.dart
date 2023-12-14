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
import 'package:genius_wallet/module/exchange/exchange_list/data/exchange_list.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/exchange_list_bloc.dart';
import '../bloc/exchange_list_event.dart';
import '../bloc/exchange_list_state.dart';

class ExchangeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExchangeListBloc()..add(InitEvent()),
      child: BlocBuilder<ExchangeListBloc,ExchangeListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, ExchangeListState state) {
    final bloc = BlocProvider.of<ExchangeListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).exchange_history
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.exchanges!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.exchanges!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              ExchangeData data = state.transfers!.response!.exchanges!.data![index];
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
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }
}

