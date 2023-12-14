import 'package:flutter/cupertino.dart';
import '../theme/app_color.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
Widget SwipeRefresh({required RefreshController controller,required VoidCallback onRefresh,VoidCallback? onLoading,List<Widget>? children,Widget? child,bool enablePullUp=false,ScrollController? scrollController}){
  return SmartRefresher(
    scrollController: scrollController,
    onRefresh: onRefresh,
    onLoading: onLoading,
    header: WaterDropMaterialHeader(backgroundColor: AppColor.primary,color: AppColor.buttonTextColor,),
    footer: const ClassicFooter(
      noDataText: '',
    ),
    enablePullDown: true,
    primary: false,
    enablePullUp: onLoading!=null ? true : false,
    controller: controller,
    child: child ?? ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: children ?? [],
    ),
  );
}

