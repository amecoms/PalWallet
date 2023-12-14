import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_wallet/Widgets/circle_button.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/default_textfield.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/app_helper/validator.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/design_component.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:genius_wallet/utils/url.dart';

import '../../../gen/assets.gen.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';
import '../bloc/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  SignInBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInBloc()..add(InitEvent(context)),
      child: BlocBuilder<SignInBloc,SignInState>(builder: (context,state) => Form(
        key: context.read<SignInBloc>().formKey,
        child: _buildPage(context,state),
      )),
    );
  }

  Widget _buildPage(BuildContext context, SignInState state) {
    bloc ??= BlocProvider.of<SignInBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.r),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      40.verticalSpace,
                      Assets.banner.image(height: 32.h),
                      30.verticalSpace,
                      Text(appLanguage(context).sign_in,style: appTheme(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: Dimension.textSemiBold,
                          fontSize: 24.spMin
                      ),),
                      20.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.email,
                        hint: appLanguage(context).email,
                        textInputType: TextInputType.emailAddress,
                        validator: Validator.emailValidator,
                        prefixIcon: Icon(Icons.email_outlined,color: AppColor.grey,),
                      ),
                      16.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.password,
                        hint: appLanguage(context).password,
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_outline_rounded,color: AppColor.grey,),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: ()=> goToPage(Routes.RESET_PASSWORD),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero
                          ),
                          child: Text(
                            '${appLanguage(context).forgot_your_password}?',
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular,
                              color: AppColor.primary
                            ),)
                        ),
                      ),
                      20.verticalSpace,
                      DefaultButton(
                        onTap: () => bloc!.add(SubmitData()),
                        isLoading: state.pageState == PageState.Loading,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            appLanguage().login,
                            style: appTheme().textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textRegular),
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${appLanguage(context).dont_have_an_account} ',
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              children: [
                                TextSpan(
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                    fontWeight: Dimension.textRegular,
                                    color: AppColor.primary
                                  ),
                                  text: appLanguage(context).sign_up,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      goAndReplacePage(Routes.SIGN_UP,arguments: bloc!.arguments);
                                    }
                                )
                              ]
                          )
                      ),
                      Dimension.bottomSpace
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 0.7.sw,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: appLanguage(context).terms_and_conditions_message,
                  style: appTheme(context).textTheme.bodyLarge!.copyWith(color: AppColor.textColor2),
                  children: [
                    TextSpan(
                      style: appTheme(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.primary
                      ),
                      text: appLanguage(context).terms_and_conditions,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          }
                    )
                  ]
                )
              ),
            ),
            16.verticalSpace
          ],
        ),
      ),
    );
  }
}

