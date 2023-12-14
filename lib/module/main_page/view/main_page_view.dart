import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_wallet/Widgets/divider_list.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/data/auth.dart';
import 'package:genius_wallet/module/main_page/view/transaction_details_sheet.dart';
import 'package:genius_wallet/utils/design_component.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/app_background.dart';
import '../../../../Widgets/circular_progress.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/network_image.dart';
import '../../../../Widgets/swipe_refresh.dart';
import '../../../../app_helper/enums.dart';
import '../../../../app_helper/helper.dart';
import '../../../../custom_icons/my_flutter_app_icons.dart' as CustomIcons;
import '../../../../main.dart';
import '../../../../module/main_page/data/drawer_tab.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';

import '../../../Widgets/default_textfield.dart';
import '../../../Widgets/dropdown_theme.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/main_page_bloc.dart';
import '../bloc/main_page_event.dart';
import '../bloc/main_page_state.dart';
import '../data/dashboard.dart';

class MainPage extends StatelessWidget {
  MainPageBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainPageBloc()..add(InitEvent()),
      child: BlocBuilder<MainPageBloc,MainPageState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, MainPageState state) {
    bloc ??= BlocProvider.of<MainPageBloc>(context);

    return Scaffold(
      key: bloc!.scaffoldKey,
      drawer: drawerView(context,state),
      body: AppBackground(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 0.7.sh,
              width: double.infinity,
              color: AppColor.white,
            ),
            Column(
              children: [
                Dimension.paddingTop.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap:(){
                          bloc!.scaffoldKey.currentState!.openDrawer();
                        },
                        child: Assets.icons.menu.svg(height: 24.h)
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${appLanguage(context).welcome}!',style: appTheme(context).textTheme.bodyMedium!.copyWith(
                              color: AppColor.white
                            ),),
                            Text((state.user!.name ?? '').capitalize,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                              color: AppColor.white,
                              fontSize: 20.spMin,
                              fontWeight: Dimension.textSemiBold
                            ),)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: ()=>goToProfilePage(),
                        child: ClipOval(
                          child: CachedImage(
                            imageUrl: state.user!.profilePhoto,
                            isProfileImage: true,
                            name: state.user!.name ?? '',
                            height: 40.h,
                            width: 40.h,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                16.verticalSpace,
                if(['0','3'].contains(state.user!.kycStatus!))
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16).copyWith(
                        bottom: 16
                    ),
                    child: DefaultButton(
                      onTap: () async {
                        await goToPage(Routes.KYC_VERIFICATION);
                        state.user = Auth.getAuth()!.response!.user;
                        bloc!.emit(state.clone());
                      },
                      backgroundColor: state.user!.kycStatus == '0' ? AppColor.yellow : AppColor.red,
                      child: Center(child: Text(
                        state.user!.kycStatus == '0' ? appLanguage(context).kyc_info_needed : appLanguage(context).kyc_info_rejected,
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                          color: state.user!.kycStatus == '0' ? AppColor.textColor : AppColor.white,
                          fontWeight: Dimension.textMedium
                        ),
                      ))
                    ),
                  ),
                Expanded(
                  child: SwipeRefresh(
                    controller: bloc!.refreshController,
                    onRefresh: ()=>bloc!.add(InitEvent()),
                    child: state.pageState == PageState.Loading ? CircularProgress(height: 1.sh) :
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          margin: REdgeInsets.symmetric(horizontal: 16).copyWith(
                            bottom: 16
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: REdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    16.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 56.h,
                                            width: 56.h,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFFFB700)
                                            ),
                                            alignment: Alignment.center,
                                            child: Assets.icons.transferMoney.svg(height: 18.h),
                                          ),
                                          16.verticalSpace,
                                          Text((state.dashboard?.response?.totalTransferMoney ?? 0).toString().toDouble.toStringAsFixed(2).price,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 20.spMin,
                                              fontWeight: Dimension.textSemiBold
                                          ),),
                                          4.verticalSpace,
                                          Text(appLanguage(context).total_money_transfer,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                            color: AppColor.textColor3
                                          ),)
                                        ],
                                      ),
                                    ),
                                    16.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 56.h,
                                            width: 56.h,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF2FB344)
                                            ),
                                            alignment: Alignment.center,
                                            child: Assets.icons.depositMpney.svg(height: 24.h),
                                          ),
                                          16.verticalSpace,
                                          Text((state.dashboard?.response?.totalDeposit ?? 0).toString().toDouble.toStringAsFixed(2).price,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 20.spMin,
                                              fontWeight: Dimension.textSemiBold
                                          ),),
                                          4.verticalSpace,
                                          Text(appLanguage(context).total_deposit,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                            color: AppColor.textColor3
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                32.verticalSpace,
                                Row(
                                  children: [
                                    16.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 56.h,
                                            width: 56.h,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFF76707)
                                            ),
                                            alignment: Alignment.center,
                                            child: Assets.icons.withdrawMoney.svg(height: 24.h),
                                          ),
                                          16.verticalSpace,
                                          Text((state.dashboard?.response?.totalWithdraw ?? 0).toString().toDouble.toStringAsFixed(2).price,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 20.spMin,
                                              fontWeight: Dimension.textSemiBold
                                          ),),
                                          4.verticalSpace,
                                          Text(appLanguage(context).total_withdraw,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              color: AppColor.textColor3
                                          ),)
                                        ],
                                      ),
                                    ),
                                    16.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 56.h,
                                            width: 56.h,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF4299E1)
                                            ),
                                            alignment: Alignment.center,
                                            child: Assets.icons.exchangeMoney.svg(height: 24.h),
                                          ),
                                          16.verticalSpace,
                                          Text((state.dashboard?.response?.totalExchange ?? 0).toString().toDouble.toStringAsFixed(2).price,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 20.spMin,
                                              fontWeight: Dimension.textSemiBold
                                          ),),
                                          4.verticalSpace,
                                          Text(appLanguage(context).total_exchange,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                              color: AppColor.textColor3
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppColor.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              8.verticalSpace,
                              Container(
                                padding:REdgeInsets.symmetric(horizontal: 4),
                                color: AppColor.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: ()=> goToPage(Routes.DEPOSIT_MONEY),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColor.primary.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(8.r)
                                              ),
                                              padding: REdgeInsets.all(16),
                                              child: Assets.icons.deposit.svg(height: 32.h),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              appLanguage(context).deposit,
                                              style: appTheme(context).textTheme.bodyLarge,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: ()=> goToPage(Routes.TRANSFER_MONEY),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF76707).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(8.r)
                                              ),
                                              padding: REdgeInsets.all(16),
                                              child: Assets.icons.transferMoney.svg(height: 32.h,color: const Color(0xFFF76707)),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              appLanguage(context).transfer,
                                              style: appTheme(context).textTheme.bodyLarge,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: ()=> goToPage(Routes.ADD_WITHDRAW),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF2FB344).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(8.r)
                                              ),
                                              padding: REdgeInsets.all(16),
                                              child: Assets.icons.withdraw.svg(height: 32.h,color: const Color(0xFF2FB344)),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              appLanguage(context).withdraw,
                                              style: appTheme(context).textTheme.bodyLarge,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: ()=> bloc!.scaffoldKey.currentState!.openDrawer(),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4299E1).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(8.r)
                                              ),
                                              padding: REdgeInsets.all(16),
                                              child: Assets.icons.more.svg(height: 32.h,color: const Color(0xFF4299E1)),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              appLanguage(context).more,
                                              style: appTheme(context).textTheme.bodyLarge,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              32.verticalSpace,
                              Container(
                                padding: REdgeInsets.symmetric(horizontal: 16),
                                color: AppColor.white,
                                child: Row(
                                  children: [
                                    Text(
                                      appLanguage(context).your_wallets,
                                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                        fontWeight: Dimension.textSemiBold,
                                        fontSize: 24.spMin
                                      ),
                                    ),
                                    16.horizontalSpace,
                                    ValueListenableBuilder<bool>(
                                      valueListenable: bloc!.amountVisibility,
                                      builder: (context, value, child) {
                                        return DefaultButton(
                                          onTap: (){
                                            bloc!.amountVisibility.value = !bloc!.amountVisibility.value;
                                          },
                                          padding: REdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                          child: Text(value ? appLanguage(context).hide_amount : appLanguage(context).show_amount)
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ),
                              16.verticalSpace,
                              SizedBox(
                                height: 165.h,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.dashboard?.response?.wallets?.length ?? 0,
                                  itemBuilder: (ctx, index){
                                    Wallets data = state.dashboard!.response!.wallets![index];
                                    return ValueListenableBuilder<bool>(
                                        valueListenable: bloc!.amountVisibility,
                                        builder: (context, value, child) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.r),
                                                color: const Color(0xFFEFEEFE)
                                            ),
                                            constraints: BoxConstraints(
                                                minWidth: 170.w
                                            ),
                                            margin: REdgeInsets.only(right: 12,left: index == 0 ? 16 : 0),
                                            padding: REdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 60.h,
                                                  width: 60.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.primary.withOpacity(0.2),
                                                      shape: BoxShape.circle
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data.currency!.symbol ?? '',
                                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                                        fontSize: 24.spMin,
                                                        color: AppColor.primary
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text('${data.currency!.symbol} ${value ? (data.balance ?? '').toDouble.toStringAsFixed(2) : '⋆⋆⋆⋆'}',style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                                    fontSize: 24.spMin,
                                                    fontWeight: Dimension.textSemiBold
                                                ),),
                                                4.verticalSpace,
                                                Text(data.currency?.code ?? '',style: appTheme(context).textTheme.bodyLarge,)
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                ),
                              ),
                              32.verticalSpace,
                              Padding(
                                padding: REdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  appLanguage(context).transactions,
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                      fontWeight: Dimension.textSemiBold,
                                      fontSize: 24.spMin
                                  ),
                                ),
                              ),
                              12.verticalSpace,
                              ListView.builder(
                                  itemCount: state.dashboard?.response?.transactions?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: REdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (ctx,index){
                                    TransactionData data = state.dashboard!.response!.transactions![index];
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
                              ),
                              16.verticalSpace,
                              Center(
                                child: DefaultButton(
                                  onTap: ()=>goToPage(Routes.TRANSACTIONS),
                                  padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                                  buttonType: ButtonType.BORDER,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        appLanguage(context).all_transaction,
                                        style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                          fontWeight: Dimension.textRegular,
                                          color: AppColor.primary
                                        ),
                                      ),
                                      8.horizontalSpace,
                                      Assets.icons.forword.svg(),
                                    ],
                                  )
                                ),
                              ),
                              Dimension.bottomSpace
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget singleSection({
    required String title,
    required String data,
    required Color color,
    required IconData icon,
    double? iconSize,
    bool isSwitched = false,
    EdgeInsetsGeometry? padding,
    IconButton? tileButton
  }){
    return Card(
      margin: padding ?? EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2)
      ),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(width: 1,color: color.withOpacity(0.5)),
              ),
              padding: EdgeInsets.all(8.r),
              margin: EdgeInsets.only(right: 8.r),
              child: Icon(icon,color: color,size: iconSize ?? 24.r,),
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: !isSwitched ? [
                Text(title ,style: appTheme().textTheme.bodySmall!.copyWith(fontWeight: Dimension.textMedium,color: AppColor.grey),),
                Text(data ,style: appTheme().textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),),
              ] : [
                Text(data ,style: appTheme().textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),),
                Text(title ,style: appTheme().textTheme.bodySmall!.copyWith(fontWeight: Dimension.textMedium,color: AppColor.grey),),
              ],
            )),
            if(tileButton!=null)
              tileButton
          ],
        ),
      ),
    );
  }

  Widget drawerView(BuildContext context, MainPageState state) {
    return Drawer(
      backgroundColor: AppColor.background,
      elevation: 10,
      width: 0.8.sw,
      child: Column(
        children: [
          DrawerHeader(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.spashScreen.keyName),
                fit: BoxFit.cover
              )
            ),
            child: InkWell(
              onTap: ()=> goToProfilePage(),
              child: Stack(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: CachedImage(
                          imageUrl: state.user?.profilePhoto ?? '',
                          isProfileImage: true,
                          height: 60.h,
                          width: 60.h,
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text((state.user?.name ?? '').capitalize,style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontSize: 24.spMin,
                              color: AppColor.white
                            ),),
                            Text(state.user?.email ?? '',style: appTheme(context).textTheme.bodyLarge!.copyWith(color: AppColor.textColor2,fontWeight: Dimension.textMedium),),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: IconButton(
                      onPressed: (){
                        bloc!.scaffoldKey.currentState!.closeDrawer();
                      },
                      icon: Icon(Icons.close,color: AppColor.white,size: 32,),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.drawerTabs.length,
                  itemBuilder: (ctx,index){
                    DrawerTab tab = state.drawerTabs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.verticalSpace,
                        Text(
                          tab.title,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: Dimension.textSemiBold,
                            fontSize: 24.spMin
                          ),
                        ),
                        24.verticalSpace,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: tab.tabs.length,
                          itemBuilder: (ctx, position){
                            SubTab subTab = tab.tabs[position];
                            return InkWell(
                              onTap: ()=>navigatePage(subTab.route,subTab.arguments),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.r),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40.w,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.primary.withOpacity(0.2),
                                        shape: BoxShape.circle
                                      ),
                                      padding: REdgeInsets.all(8),
                                      child: SvgPicture.asset(subTab.icon,color: AppColor.iconColor,),
                                    ),
                                    16.horizontalSpace,
                                    Expanded(
                                      child: Text(subTab.title,style: appTheme(context).textTheme.headlineMedium!.copyWith(
                                          fontWeight: Dimension.textMedium,
                                          fontSize: 20.spMin
                                      ),),
                                    ),
                                    Assets.icons.forword.svg(),
                                    8.horizontalSpace
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      ],
                    );
                  },
                ),
                Dimension.bottomSpace
              ],
            ),
          )
        ],
      ),
    );
  }

  void showTransactionDetails(TransactionData data){
    DesignComponent.showBottomSheetPopup(child: TransactionDetailsSheet(data));
  }

  void navigatePage(String? route,dynamic arguments){
    bloc!.scaffoldKey.currentState!.closeDrawer();
    if(route!=null){
      goToPage(route,arguments: arguments);
    }
  }

  Future<void> goToProfilePage() async {
    bloc!.scaffoldKey.currentState!.closeDrawer();
    await goToPage(Routes.SETTINGS);
    bloc!.add(UpdateUser());
  }

}

