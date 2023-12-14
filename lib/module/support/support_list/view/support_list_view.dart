import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/empty_page.dart';
import 'package:genius_wallet/Widgets/swipe_refresh.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/module/support/support_list/data/tickets.dart';
import 'package:genius_wallet/module/support/support_list/view/create_ticket_sheet.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/design_component.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes/app_pages.dart';
import '../bloc/support_list_bloc.dart';
import '../bloc/support_list_event.dart';
import '../bloc/support_list_state.dart';

class SupportListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SupportListBloc()..add(InitEvent()),
      child: BlocBuilder<SupportListBloc,SupportListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SupportListState state) {
    final bloc = BlocProvider.of<SupportListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).support_tickets
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16).copyWith(
                top: 24,bottom: 16
            ),
            child: DefaultButton(
                onTap: (){
                  DesignComponent.showBottomSheetPopup(
                    context: context,
                    isScrollControlled: true,
                    child: CreateTicketSheet(bloc)
                  );
                },
                child: Center(
                    child: Text(
                      '+ ${appLanguage(context).open_a_ticket}',
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: Dimension.textMedium,
                          color: AppColor.white
                      ),
                    )
                )
            ),
          ),
          Padding(
            padding: REdgeInsets.all(16),
            child: Text(
              appLanguage(context).tickets,
              style: appTheme(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: Dimension.textSemiBold,
                  fontSize: 24.spMin
              ),
            ),
          ),
          Expanded(
            child: SwipeRefresh(
              controller: bloc.refreshController,
              onRefresh: (){
                bloc.add(InitEvent());
                bloc.add(GetData());
              },
              onLoading: ()=>bloc.add(GetData()),
              child: state.tickets == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.tickets!.response!.tickets!.data!.isNotEmpty ?
              ListView.builder(
                  itemCount: state.tickets!.response!.tickets!.data!.length,
                  shrinkWrap: true,
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (ctx,index){
                    SingleTicket data = state.tickets!.response!.tickets!.data![index];
                    return InkWell(
                      onTap: ()=> goToPage(Routes.SUPPORT_DETAILS, arguments: data.ticketNum),
                      child: Card(
                        margin: REdgeInsets.only(bottom: 16,),
                        child: Container(
                          padding: REdgeInsets.symmetric(horizontal: 16,vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.subject ?? '',
                                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                        fontWeight: Dimension.textMedium
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd MMM yyyy').format(DateTime.parse(data.updatedAt ?? '')),
                                    style: appTheme(context).textTheme.bodyLarge
                                  ),
                                ],
                              ),
                              4.verticalSpace,
                              Text(
                                data.ticketNum ?? '',
                                style: appTheme(context).textTheme.bodyMedium
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
            ),
          ),
        ],
      ),
    );
  }
}

