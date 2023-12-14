import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_wallet/Widgets/divider_list.dart';
import 'package:genius_wallet/Widgets/network_image.dart';
import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/message_dialog.dart';
import '../../../../app_helper/extensions.dart';
import '../../../../app_helper/helper.dart';
import '../../../../controllers/app_controller/bloc/app_controller_event.dart';
import '../../../../controllers/app_controller/data/languages.dart';
import '../../../../controllers/share_helper.dart';
import '../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';

import '../../data/auth.dart';
import '../../gen/assets.gen.dart';
import '../../utils/url.dart';
import 'settings_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsPage extends StatelessWidget {
  SettingsBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsBloc()..add(InitEvent(context)),
      child: BlocBuilder<SettingsBloc,SettingsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SettingsState state) {
    bloc ??= BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      body: mainView(context,state),
    );
  }

  Widget mainView(BuildContext context, SettingsState state){
    return CustomScrollView(
      controller: bloc!.scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: true,
          expandedHeight: (280 - Dimension.appbarHeight).h,
          backgroundColor: AppColor.background,
          iconTheme: IconThemeData(
            color: AppColor.white
          ),
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  appLanguage(context).profile,
                  style: appTheme(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 20.spMin,
                    color: AppColor.white
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: bloc!.imagePlace,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: InkWell(
                      onTap: ()=> editProfile(),
                      child: ClipOval(
                        child: CachedImage(
                          imageUrl: state.auth!.response!.user!.profilePhoto,
                          height: 32.h,
                          width: 32.h,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          flexibleSpace: Stack(
            children: [
              Assets.images.profileBack.image(
                  fit: BoxFit.cover,
                  height: 280.h,
                  width: 1.sw
              ),
              FlexibleSpaceBar(
                background: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dimension.paddingTop.verticalSpace,
                    InkWell(
                      onTap: ()=> editProfile(),
                      child: ClipOval(
                        child: CachedImage(
                          imageUrl: state.auth!.response!.user!.profilePhoto,
                          height: 80.h,
                          width: 80.h,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      state.auth!.response!.user!.name ?? '',
                      style: appTheme(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.spMin,
                        fontWeight: Dimension.textSemiBold,
                        color: AppColor.white,
                        height: 1
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      state.auth!.response!.user!.email ?? '',
                      style: appTheme(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.white,
                        height: 1
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              24.verticalSpace,
              singleItem(
                onTap: ()=> editProfile(),
                icon: Assets.icons.user.keyName,
                title: appLanguage(context).profile_setting
              ),
              singleItem(
                onTap: ()=> goToPage(Routes.QR_PAGE),
                icon: Assets.icons.barcode.keyName,
                title: appLanguage(context).qr_code
              ),
              if(state.settings!.response!.twoFa! == "1")
                singleItem(
                  onTap: ()=> goToPage(Routes.TWO_FA_VERIFICATION),
                  icon: Assets.icons.security.keyName,
                  title: appLanguage(context).two_step_security
                ),
              singleItem(
                onTap: ()=> goToPage(Routes.SUPPORT_PAGES),
                icon: Assets.icons.support.keyName,
                title: appLanguage(context).support_ticket
              ),
              singleItem(
                onTap: ()=> logoutDialog(),
                icon: Assets.icons.logout.keyName,
                title: appLanguage(context).sign_out,
                showDivider: false
              ),
              300.verticalSpace
            ],
          ),
        )
      ]
    );
  }

  Widget singleItem({required VoidCallback onTap, required String icon, required String title,bool showDivider=true,}){
    return DividerList(
      padding: REdgeInsets.all(16),
      showDivider: showDivider,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary.withOpacity(0.2)
              ),
              padding: REdgeInsets.all(12),
              child: SvgPicture.asset(icon),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: appTheme().textTheme.bodyLarge!.copyWith(
                  fontSize: 16.spMin
                ),
              ),
            ),
            Assets.icons.forword.svg()
          ],
        )
      )
    );
  }

  void logoutDialog(){
    MessageDialog(
      title: appLanguage().logout,
      message: appLanguage().are_you_sure_you_want_to_logout,
      isConfirmDialog: true,
      onTap: (state){
        backPage();
        if(state){
          ShareHelper.logOut();
        }
      }
    );
  }

  Future editProfile() async {
    await goToPage(Routes.EDIT_PROFILE);
    bloc!.emit(bloc!.state.clone(
      auth: Auth.getAuth()
    ));
  }
}

