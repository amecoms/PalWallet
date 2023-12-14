import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import '../../../../Widgets/circle_button.dart';
import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../Widgets/empty_view.dart';
import '../../../../app_helper/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/escrow_dispute_bloc.dart';
import '../bloc/escrow_dispute_event.dart';
import '../bloc/escrow_dispute_state.dart';
import '../data/escrow_dispute.dart';
import 'package:path/path.dart';

class EscrowDisputePage extends StatelessWidget {
  EscrowDisputeBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EscrowDisputeBloc()..add(InitEvent(context)),
      child: BlocBuilder<EscrowDisputeBloc,EscrowDisputeState>(
        builder: (context,state) => _buildPage(context,state)
      ),
    );
  }

  Widget _buildPage(BuildContext context, EscrowDisputeState state) {
    bloc ??= BlocProvider.of<EscrowDisputeBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: state.messages!=null ? '${appLanguage(context).escrow}: ${state.messages!.response!.escrow!.trnx}' : appLanguage().messages,
        centerTitle: false
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  controller: bloc!.scrollController,
                  padding: EdgeInsets.only(bottom: 65.r),
                  children: [
                    state.messages!=null ? state.messages!.response!.messages!.isNotEmpty ?
                    messageView(state.messages!) : EmptyView() : CircularProgress(
                      height: 0.8.sh
                    ),
                  ],
                ),
              ),
              (Dimension.paddingBottom + (state.messageFile != null ? 80.h : 0) + 16).verticalSpace
            ],
          ),
          Positioned(
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state.messageFile != null)
                  Container(
                    height: 80.h,
                    width: 1.sw,
                    color: AppColor.white,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Image.file(
                              state.messageFile!,
                              fit: BoxFit.cover,
                              width: 80.h,
                              height: 80.h,
                            ),
                            8.horizontalSpace,
                            Expanded(child: Text(basename(state.messageFile!.path)))
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: (){
                              state.messageFile = null;
                              bloc!.emit(state.clone());
                            },
                            icon: Icon(Icons.cancel,color: AppColor.red,),
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  width: 1.sw,
                  color: AppColor.cardColor,
                  padding: EdgeInsets.only(bottom: Dimension.paddingBottom),
                  child: DefaultTextField(
                    controller: bloc!.message,
                    hint: appLanguage().type_a_message,
                    enableValidation: false,
                    borderRadius: 0,
                    prefixIcon: IconButton(
                      onPressed: ()=> bloc!.add(AttachFile()),
                      icon: Assets.icons.gallery.svg(height: 18.h,color: AppColor.primary),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.buttonTextColor,
                              shape: BoxShape.circle
                          ),
                          child: CircleButton(
                              loading: state.pageState == PageState.Loading,
                              onTap: ()=> bloc!.add(SendMessageEvent()),
                              loadingColor: AppColor.primary,
                              child: Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Icon(Icons.send,color: AppColor.primary,size: 20.r,),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget messageView(EscrowDispute messages) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messages.response!.messages!.length,
        itemBuilder: (context,i){
          bool isMind=messages.response!.messages![i].userId!=null ? messages.response!.messages![i].userId == bloc!.state.auth!.response!.user!.id!.toString() : false;
          return Container(
            alignment: isMind ? Alignment.bottomRight : Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 16.r,left: isMind ? 0.2.sw : 0 ,right: isMind ? 0 : 0.2.sw),
            child: isMind ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 5.r),
                  decoration: BoxDecoration(
                      color: isMind ? AppColor.primary : AppColor.buttonTextColor,
                      borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20.r),topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)) :
                      BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r),topLeft: Radius.circular(20.r))
                  ),
                  child: Text(messages.response!.messages![i].message ?? '',style: appTheme(context).textTheme.bodyLarge!.copyWith(color: isMind ? AppColor.buttonTextColor : AppColor.textColor),)
                ),
                if(messages.response!.messages![i].file != null)
                  InkWell(
                    onTap: ()=> bloc!.add(DownloadFile(messages.response!.messages![i].file ?? '')),
                    child: Container(
                      margin: REdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        appLanguage().attached_a_file,
                        style: appTheme(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.primary,
                          fontWeight: Dimension.textMedium
                        ),
                      )
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(top: 3.r,right: isMind ? 5.r : 0 ,left: isMind ? 0 : 5.r),
                  child: Text(messages.response!.messages![i].createdAt!.timeAgo,style: appTheme(context).textTheme.bodyMedium!.copyWith(fontSize: 10.spMin),),
                )
              ],
            ) : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 5.r),
                  decoration: BoxDecoration(
                      color: isMind ? AppColor.primary : AppColor.cardColor,
                      borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20.r),topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)) :
                      BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r),topLeft: Radius.circular(20.r))
                  ),
                  child: Text(messages.response!.messages![i].message ?? '',style: appTheme(context).textTheme.bodyLarge!.copyWith(color: isMind ? AppColor.buttonTextColor : AppColor.textColor),)
                ),
                if(messages.response!.messages![i].file != null)
                  InkWell(
                    onTap: ()=> bloc!.add(DownloadFile(messages.response!.messages![i].file ?? '')),
                    child: Container(
                      margin: REdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        appLanguage().attached_a_file,
                        style: appTheme(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.primary,
                          fontWeight: Dimension.textMedium
                        ),
                      )
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(top: 3.r,right: !isMind ? 5.r : 0 ,left: !isMind ? 0 : 5.r),
                  child: Text(messages.response!.messages![i].createdAt!.timeAgo,style: appTheme(context).textTheme.bodyMedium!.copyWith(fontSize: 10.spMin),),
                )
              ],
            ),
          );
        }
    );
  }
}

