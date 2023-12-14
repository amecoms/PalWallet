import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/main.dart';

import '../../../Widgets/default_dialog.dart';
import '../../../Widgets/default_textfield.dart';
import '../../../app_helper/helper.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../bloc/two_fa_verification_bloc.dart';
import '../bloc/two_fa_verification_event.dart';
import '../bloc/two_fa_verification_state.dart';

class TwoFAVerificationPage extends StatelessWidget {
  TwoFAVerificationBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TwoFAVerificationBloc()..add(InitEvent()),
      child: BlocBuilder<TwoFAVerificationBloc,TwoFAVerificationState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TwoFAVerificationState state) {
    bloc ??= BlocProvider.of<TwoFAVerificationBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).two_fa_security),
      body: Form(
        key: bloc!.formKey,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              20.verticalSpace,
              if(state.user.twoFaStatus == "1" )
                Column(
                  children: [
                    Text(
                      appLanguage(context).two_step_authentication_is_enabled,
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        color: AppColor.green
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              DefaultTextField(
                controller: bloc!.password,
                backgroundColor: AppColor.textFieldBackground,
                label: appLanguage(context).password,
                hint: appLanguage(context).password,
                obscureText: true,
                labelAsTitle: true,
              ),
              15.verticalSpace,
              DefaultTextField(
                controller: bloc!.conPassword,
                backgroundColor: AppColor.textFieldBackground,
                label: appLanguage(context).confirm_password,
                hint: appLanguage(context).confirm_password,
                obscureText: true,
                labelAsTitle: true,
              ),
              15.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc!.add(SendTwoFaCode()),
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    state.user.twoFaStatus != "1" ? appLanguage(context).enable_two_factor_authenticator : appLanguage(context).disable_two_factor_authenticator,
                    style: appTheme(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: Dimension.textMedium,
                      color: AppColor.white
                    )
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

}

