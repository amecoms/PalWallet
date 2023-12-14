import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/empty_page.dart';
import 'package:genius_wallet/Widgets/swipe_refresh.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../transfer_money/data/transfer_log.dart';
import '../../transfer_money/view/single_transfer.dart';
import '../bloc/transfer_list_bloc.dart';
import '../bloc/transfer_list_event.dart';
import '../bloc/transfer_list_state.dart';

class TransferListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TransferListBloc()..add(InitEvent()),
      child: BlocBuilder<TransferListBloc,TransferListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TransferListState state) {
    final bloc = BlocProvider.of<TransferListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).transfer_history
      ),
      body: SwipeRefresh(
        controller: bloc.refreshController,
        onRefresh: (){
          bloc.add(InitEvent());
          bloc.add(GetData());
        },
        onLoading: ()=>bloc.add(GetData()),
        child: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.response!.transferHistory!.data!.isNotEmpty ?
        ListView.builder(
            itemCount: state.transfers!.response!.transferHistory!.data!.length,
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (ctx,index){
              TransferData data = state.transfers!.response!.transferHistory!.data![index];
              return SingleTransfer(data);
            }
        ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound.keyName)
      ),
    );
  }
}

