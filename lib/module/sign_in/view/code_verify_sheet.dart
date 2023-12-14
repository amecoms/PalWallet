import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/module/sign_in/bloc/sign_in_bloc.dart';
import 'package:genius_wallet/module/sign_in/bloc/sign_in_state.dart';
import 'package:genius_wallet/module/two_fa_verification/bloc/two_fa_verification_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:intl/intl.dart';

import '../../../Widgets/circular_progress.dart';
import '../../../Widgets/default_button.dart';
import '../../../Widgets/default_textfield.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../bloc/sign_in_event.dart';

class CodeVerifySheet extends StatelessWidget {
  final SignInBloc bloc;
  CodeVerifySheet(this.bloc,{super.key});
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      bloc: bloc,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(20.r),
                topStart: Radius.circular(20.r),
              ),
              color: AppColor.white,
            ),
            padding: REdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () => backPage(),
                      icon: Icon(Icons.close_rounded,
                          color: AppColor.iconColor)),
                ),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      8.verticalSpace,
                      DefaultTextField(
                        controller: bloc.code,
                        backgroundColor: AppColor.textFieldBackground,
                        label: appLanguage(context).verification_code,
                        hint: appLanguage(context).verification_code,
                        labelAsTitle: true,
                      ),
                      8.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: Countdown(
                          controller: bloc.countdownController,
                          seconds: 60,
                          build: (_, double time){
                            return state.pageState == PageState.Loading ? CircularProgress(size: 24) : RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: appLanguage(context).received_nothing,
                                    style: appTheme(context).textTheme.bodyMedium,
                                    children: [
                                      time.toInt() != 0 ? TextSpan(
                                        text: ' ${appLanguage(context).resend_code_in.replaceAll('@', '${time.toInt()}')}',
                                        style: appTheme(context).textTheme.bodyMedium,
                                      ) : TextSpan(
                                        text: ' ${appLanguage(context).resend_code}',
                                        style: appTheme(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: Dimension.textBold,
                                            decoration: TextDecoration.underline
                                        ),
                                        recognizer: TapGestureRecognizer()..onTap = () => bloc.add(SendTwoFaCode()),
                                      )
                                    ]
                                )
                            );
                          },
                          onFinished: () {
                          },
                        ),
                      )
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        bloc.add(VerifyCode());
                      }
                    },
                    isLoading: state.verificationLoading,
                    padding: REdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(appLanguage(context).verify,
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 17.spMin,
                            fontWeight: Dimension.textSemiBold,
                            color: AppColor.white
                        ),
                      ),
                    ),
                  ),
                ),
                Dimension.bottomSpace
              ],
            ),
          ),
        );
      },
    );
  }
}
