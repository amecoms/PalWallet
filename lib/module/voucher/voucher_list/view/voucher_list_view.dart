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
import '../bloc/voucher_list_bloc.dart';
import '../bloc/voucher_list_event.dart';
import '../bloc/voucher_list_state.dart';
import '../data/voucher_list.dart';

class VoucherListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VoucherListBloc()..add(InitEvent()),
      child: BlocBuilder<VoucherListBloc,VoucherListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, VoucherListState state) {
    final bloc = BlocProvider.of<VoucherListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).my_vouchers
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.vouchers!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.vouchers!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              Voucher data = state.transfers!.response!.vouchers!.data![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                color: AppColor.white,
                margin: REdgeInsets.only(bottom: 16,top: index == 0 ? 16 : 0),
                child: Container(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    data.code ?? '',
                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                                  ),
                                  8.horizontalSpace,
                                  InkWell(
                                    onTap: ()=> Helper.copyText(data.code ?? ''),
                                    child: Icon(Icons.copy,color: AppColor.primary,size: 16.h,),
                                  )
                                ],
                              )
                          ),
                          Text(
                            '${(data.amount ?? '0').toDouble.toStringAsFixed(0)} ${data.currency!.code}',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                DateFormat('dd MMM yyyy -- hh:mm a').format(DateTime.parse(data.createdAt ?? '')),
                                style: appTheme(context).textTheme.bodyMedium,
                              )
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: data.status! == '0' ? AppColor.textColor : AppColor.green
                            ),
                            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: Text(
                              data.status! == '0' ? appLanguage().unused : appLanguage(context).used,
                              style: appTheme(context).textTheme.bodySmall!.copyWith(
                                  color: AppColor.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }
}

