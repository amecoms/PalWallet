import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/default_appbar.dart';
import '../../Widgets/default_button.dart';
import '../../Widgets/default_textfield.dart';
import '../../app_helper/enums.dart';
import '../../app_helper/helper.dart';
import '../../main.dart';
import '../../theme/app_color.dart';
import '../../utils/dimension.dart';
import 'contact_us_bloc.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ContactUsBloc()..add(InitEvent()),
      child: BlocBuilder<ContactUsBloc,ContactUsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, ContactUsState state) {
    final bloc = BlocProvider.of<ContactUsBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).contact_us),
      body: Form(
        key: bloc.fromKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if(state.contactInfo!=null)
              Container(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,
                    Text(state.contactInfo!.data!.subtitle ?? '',style: appTheme(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 34.spMin,
                      color: AppColor.primary,
                      height: 1.2
                    ),),
                    5.verticalSpace,
                    Text(state.contactInfo!.data!.description ?? '',style: appTheme(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.grey
                    ),),
                    16.verticalSpace,
                    singleSection(
                      appLanguage(context).address,
                      state.contactInfo!.data!.address ?? '',
                      Icons.location_on
                    ),
                    16.verticalSpace,
                    singleSection(
                      appLanguage(context).call_us,
                      state.contactInfo!.data!.phone ?? '',
                      Icons.phone,
                      onTap: ()=> Helper.makeCall(state.contactInfo!.data!.phone!)
                    ),
                    16.verticalSpace,
                    singleSection(
                      appLanguage(context).email_us,
                      state.contactInfo!.data!.email ?? '',
                      Icons.email,
                      onTap: ()=> Helper.sendMail(state.contactInfo!.data!.email!)
                    ),
                    8.verticalSpace
                  ],
                ),
              ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: DefaultTextField(
                controller: bloc.name,
                label: appLanguage().name,
                isRequired:true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:16.r,right: 16.r,top: 16.r),
              child: DefaultTextField(
                  controller: bloc.phone,
                  label: appLanguage().phone_number,
                  isRequired: true,
                  textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:16.r,right: 16.r,top: 16.r),
              child: DefaultTextField(
                  controller: bloc.email,
                  label: appLanguage().email,
                  textInputType: TextInputType.emailAddress,
                  isRequired: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:16.r,right: 16.r,top: 16.r),
              child: DefaultTextField(
                  controller: bloc.subject,
                  label: appLanguage().subject,
                  isRequired: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:16.r,right: 16.r,top: 16.r),
              child: DefaultTextField(
                  controller: bloc.message,
                  label: appLanguage().your_message,
                  isRequired: true,
                  maxLine: 5
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: DefaultButton(
                isLoading: state.pageState == PageState.Loading,
                onTap: ()=> bloc.add(SubmitMessageEvent()),
                child: Container(
                    width: 140,
                    alignment: Alignment.center,
                    child: Text(appLanguage().send_message,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor),)
                ),
              ),
            ),
            Dimension.bottomSpace,
          ],
        ),
      ),
    );
  }

  Widget singleSection(String title, String data, IconData icon,{VoidCallback? onTap}){
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              border: Border.all(width: 2,color: AppColor.green)
            ),
            padding: REdgeInsets.all(8),
            child: Icon(icon,color: AppColor.green,),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: appTheme().textTheme.headlineMedium,),
                4.verticalSpace,
                Text(data,style: appTheme().textTheme.bodyMedium!.copyWith(
                  color: AppColor.green
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }

}

