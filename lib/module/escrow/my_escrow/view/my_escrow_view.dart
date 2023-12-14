import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/empty_page.dart';
import 'package:genius_wallet/Widgets/swipe_refresh.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/my_escrow_bloc.dart';
import '../bloc/my_escrow_event.dart';
import '../bloc/my_escrow_state.dart';
import '../data/escrow_list.dart';

class MyEscrowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyEscrowBloc()..add(InitEvent()),
      child: BlocBuilder<MyEscrowBloc,MyEscrowState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, MyEscrowState state) {
    final bloc = BlocProvider.of<MyEscrowBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).my_escrow
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.escrows!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.escrows!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              EscData data = state.transfers!.response!.escrows!.data![index];
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
                            data.recipientEmail ?? '',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium,color: Colors.blue),
                          )
                      ),
                      Text(
                        '${(data.amount ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
                        style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                      )
                    ],
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              appLanguage(context).transaction_id.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                        ),
                        Text(
                          data.trnx ?? '',
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
                          '${(data.charge ?? '0').toDouble.toStringAsFixed(1)} ${data.currency!.code}',
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
                          padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Text(
                            data.status!.escrowStatusName.toUpperCase(),
                            style: appTheme().textTheme.bodySmall
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLanguage(context).description.toUpperCase(),
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),
                          ),
                          6.verticalSpace,
                          Text(
                            data.description ?? '',
                            style: appTheme(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    8.verticalSpace,
                    if([0,3].contains(data.status!.toInt))
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onTap: ()=> bloc.add(ReleaseEscrow(index)),
                            padding: REdgeInsets.symmetric(vertical: 8),
                            isLoading: data.isLoading,
                            backgroundColor: Colors.blue,
                            child: Center(
                              child: Text(appLanguage(context).release),
                            ),
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: DefaultButton(
                            onTap: ()=> goToPage(Routes.MY_ESCROW_DISPUTE,arguments: data.id.toString()),
                            padding: REdgeInsets.symmetric(vertical: 8),
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Center(
                              child: Text(appLanguage(context).dispute),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }
}

