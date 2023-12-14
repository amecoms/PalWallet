import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../Widgets/phone_textfield.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';

import '../../Widgets/network_image.dart';
import '../../gen/assets.gen.dart';
import 'my_profile_bloc.dart';
import 'my_profile_event.dart';
import 'my_profile_state.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyProfileBloc()..add(InitEvent()),
      child: BlocConsumer<MyProfileBloc, MyProfileState>(
        listener: (context, state) {},
        builder: (context, state) => Form(
          key: context.read<MyProfileBloc>().formKey,
          child: Scaffold(
            body: _buildPage(context, state),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, MyProfileState state) {
    final bloc = BlocProvider.of<MyProfileBloc>(context);

    return CustomScrollView(
        controller: bloc.scrollController,
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
                  valueListenable: bloc.imagePlace,
                  builder: (context, value, child) {
                    return Visibility(
                      visible: value,
                      child: ClipOval(
                        child: CachedImage(
                          imageUrl: state.auth!.response!.user!.profilePhoto,
                          height: 32.h,
                          width: 32.h,
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
                        onTap: ()=> bloc.add(ChangeImage()),
                        child: Stack(
                          children: [
                            ClipOval(
                              child: state.image == null ? CachedImage(
                                imageUrl: state.auth!.response!.user!.profilePhoto,
                                height: 80.h,
                                width: 80.h,
                              ) : Image.file(
                                state.image!,
                                height: 80.h,
                                width: 80.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Assets.icons.edit2.svg(height: 24.h),
                            )
                          ],
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
              padding: REdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                24.verticalSpace,
                DefaultTextField(
                  controller: bloc.name,
                  label: appLanguage(context).name,
                  hint: appLanguage(context).name,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultTextField(
                  controller: bloc.email,
                  label: appLanguage(context).email,
                  enable: false,
                  hint: appLanguage(context).email,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                PhoneTextField(
                  controller: bloc.phoneController,
                  label: appLanguage(context).phone_number,
                  hint: appLanguage(context).phone_number,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultTextField(
                  controller: bloc.zipCode,
                  label: appLanguage(context).zip_code,
                  hint: appLanguage(context).zip_code,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultTextField(
                  controller: bloc.city,
                  label: appLanguage().city,
                  hint: appLanguage(context).city,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultTextField(
                  controller: bloc.country,
                  label: appLanguage().country,
                  hint: appLanguage(context).country,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultTextField(
                  controller: bloc.address,
                  label: appLanguage().address,
                  hint: appLanguage(context).address,
                  labelAsTitle: true,
                ),
                20.verticalSpace,
                DefaultButton(
                  backgroundColor: AppColor.background,
                  borderColor: AppColor.primary,
                  buttonType: ButtonType.BORDER,
                  onTap: () {
                    goToPage(Routes.CHANGE_PASSWORD);
                  },
                  child: Text(
                    appLanguage().change_password,
                    style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.primary),
                  ),
                ),
                20.verticalSpace,
                DefaultButton(
                  isLoading: bloc.state.pageState == PageState.Loading,
                  onTap: () => bloc.add(SubmitEvent()),
                  child: Text(
                    appLanguage().save_change,
                    style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),
                  ),
                ),
                Dimension.bottomSpace,
                300.verticalSpace
              ],
            ),
          )
        ]
    );

  }
}
