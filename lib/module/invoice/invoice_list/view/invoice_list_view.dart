import 'package:flutter/cupertino.dart';
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
import 'package:genius_wallet/utils/design_component.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/invoice_list_bloc.dart';
import '../bloc/invoice_list_event.dart';
import '../bloc/invoice_list_state.dart';
import '../data/invoice_history.dart';
import 'invoice_details_sheet.dart';

class InvoiceListPage extends StatelessWidget {
  InvoiceListBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => InvoiceListBloc()..add(InitEvent()),
      child: BlocBuilder<InvoiceListBloc,InvoiceListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, InvoiceListState state) {
    bloc ??= BlocProvider.of<InvoiceListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).invoices
      ),
      body: AbsorbPointer(
        absorbing: state.statusChangeState == PageState.Loading,
        child: SwipeRefresh(
          controller: bloc!.refreshController,
          onRefresh: (){
            bloc!.add(InitEvent());
            bloc!.add(GetData());
          },
          onLoading: ()=>bloc!.add(GetData()),
          child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.invoices!.data!.isNotEmpty ?
          ListView.builder(
              itemCount: state.transfers!.response!.invoices!.data!.length,
              shrinkWrap: true,
              padding: REdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (ctx,index){
                InvoiceData data = state.transfers!.response!.invoices!.data![index];
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
                              data.number ?? '',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium,color: Colors.blue),
                            )
                        ),
                        Text(
                          '${(data.finalAmount ?? '0').toDouble.toStringAsFixed(1)}  ${data.currency?.code}',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                        )
                      ],
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                appLanguage(context).invoice_to.toUpperCase(),
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                          ),
                          Text(
                            data.invoiceTo ?? '',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                appLanguage(context).email.toUpperCase(),
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                          ),
                          Text(
                            data.email ?? '',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              appLanguage(context).pay_status.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ),
                          Visibility(
                            visible: (data.status ?? '0') != '2',
                            maintainState: true,
                            maintainSize: true,
                            maintainAnimation: true,
                            child: CupertinoSwitch(
                              value: (data.paymentStatus ?? '0').toInt == 1,
                              activeColor: AppColor.primary,
                              onChanged: (value)=> bloc!.add(ChangePaymentStatus(index))
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: data.paymentStatus!.statusColor
                              ),
                              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              child: Text(
                                data.paymentStatus!.paymentStatusName.toUpperCase(),
                                style: appTheme().textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              appLanguage(context).publish_status.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ),
                          Visibility(
                            visible: (data.status ?? '0') == '0',
                            maintainState: true,
                            maintainSize: true,
                            maintainAnimation: true,
                            child: CupertinoSwitch(
                              value: (data.status ?? '0').toInt == 1,
                              activeColor: AppColor.primary,
                              onChanged: (value)=> bloc!.add(ChangePublishStatus(index))
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: data.status!.statusColor
                              ),
                              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              child: Text(
                                data.status!.invoiceStatusName.toUpperCase(),
                                style: appTheme().textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                            '${(data.charge ?? '0').toDouble.toStringAsFixed(1)} ${data.currency?.code}',
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
                      12.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              appLanguage(context).action.toUpperCase(),
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                            )
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: ()=> showInvoice(context,data),
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColor.textColor
                                  ),
                                  alignment: Alignment.center,
                                  child: Assets.icons.view.svg(height: 24.h),
                                ),
                              ),
                              if((data.status ?? '0') == '0')
                                Row(
                                  children: [
                                    16.horizontalSpace,
                                    InkWell(
                                      onTap: ()=> bloc!.add(UpdateInvoice(index)),
                                      child: Container(
                                        height: 40.h,
                                        width: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.r),
                                          color: AppColor.primary
                                        ),
                                        alignment: Alignment.center,
                                        child: Assets.icons.edit2.svg(height: 24.h),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                      8.verticalSpace,
                    ],
                  ),
                );
              }
          ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
        ),
      ),
    );
  }

  void showInvoice(BuildContext context, InvoiceData data){
    DesignComponent.showBottomSheetPopup(
      context: context,
      isScrollControlled: true,
      child: InvoiceDetailsSheet(data,bloc!)
    );
  }
}

