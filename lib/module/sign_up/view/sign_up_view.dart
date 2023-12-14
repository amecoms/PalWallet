import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Widgets/circle_button.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../Widgets/phone_textfield.dart';
import '../../../../app_helper/enums.dart';
import '../../../../app_helper/validator.dart';
import '../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/design_component.dart';
import '../../../../utils/dimension.dart';

import '../../../app_helper/helper.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/url.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';
import '../bloc/sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpBloc()..add(InitEvent(context)),
      child: BlocBuilder<SignUpBloc,SignUpState>(builder: (context,state) => Form(
        key: context.read<SignUpBloc>().formKey,
        child: _buildPage(context,state),
      )),
    );
  }

  Widget _buildPage(BuildContext context, SignUpState state) {
    bloc ??= BlocProvider.of<SignUpBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Dimension.appbarHeight,
              alignment: Alignment.centerLeft,
              child: BackButton(
                onPressed: (){
                  goAndReplacePage(Routes.SIGN_IN);
                }
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.r),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      16.verticalSpace,
                      Text(appLanguage(context).create_an_account,style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: Dimension.textSemiBold,
                        fontSize: 24.spMin
                      ),),
                      20.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.name,
                        hint: appLanguage(context).name,
                        prefixIcon: Icon(Icons.person_outline_rounded,color: AppColor.grey,),
                      ),
                      16.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.email,
                        hint: appLanguage(context).email,
                        textInputType: TextInputType.emailAddress,
                        validator: Validator.emailValidator,
                        prefixIcon: Icon(Icons.email_outlined,color: AppColor.grey,),
                      ),
                      16.verticalSpace,
                      PhoneTextField(
                        controller: bloc!.phoneController,
                        hint: appLanguage(context).phone_number,
                        prefixIcon: Icon(Icons.phone_outlined,color: AppColor.grey,)
                      ),
                      16.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.country,
                        hint: appLanguage(context).country,
                        prefixIcon: Icon(Icons.location_on_outlined,color: AppColor.grey,),
                      ),
                      16.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.address,
                        hint: appLanguage(context).address,
                        prefixIcon: Icon(Icons.location_city_outlined,color: AppColor.grey,),
                      ),
                      16.verticalSpace,
                      DefaultTextField(
                        controller: bloc!.password,
                        hint: appLanguage(context).password,
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_outline_rounded,color: AppColor.grey,),
                      ),
                      20.verticalSpace,
                      DefaultButton(
                        onTap: () => bloc!.add(SubmitData()),
                        isLoading: state.pageState == PageState.Loading,
                        child: Center(
                          child: Text(
                            appLanguage().sign_up,
                            style: appTheme().textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textRegular),
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                            width: 24.h,
                            child: Checkbox(
                              value: state.isAgree,
                              activeColor: AppColor.primary,
                              onChanged: (value)=> bloc!.add(ChangeAgree(value ?? false))
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: RichText(
                                text: TextSpan(
                                    text: appLanguage(context).i_agree_to_the_company,
                                    style: appTheme(context).textTheme.bodyLarge!.copyWith(color: AppColor.textColor3,height: 1.5),
                                    children: [
                                      TextSpan(
                                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                                          color: AppColor.primary
                                        ),
                                        text: appLanguage(context).terms_and_conditions,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {

                                          }
                                      ),
                                      TextSpan(
                                        text: ' ${appLanguage(context).and} '
                                      ),
                                      TextSpan(
                                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                                            color: AppColor.primary
                                        ),
                                        text: appLanguage(context).privacy_policy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {

                                          }
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ],
                      ),
                      32.verticalSpace,
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${appLanguage(context).already_have_an_account} ',
                              style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textRegular),
                              children: [
                                TextSpan(
                                    style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                      color: AppColor.primary,
                                      fontWeight: Dimension.textRegular
                                    ),
                                    text: appLanguage(context).sign_in,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        goAndReplacePage(Routes.SIGN_IN);
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
          ],
        ),
      ),
    );
  }
}

