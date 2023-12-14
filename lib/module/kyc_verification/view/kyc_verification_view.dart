import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/app_helper/extensions.dart';

import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../Widgets/circular_progress.dart';
import '../../../Widgets/divider_list.dart';
import '../../../Widgets/get_image.dart';
import '../../../Widgets/widget_validation.dart';
import '../../../utils/dimension.dart';
import '../bloc/kyc_verification_bloc.dart';
import '../bloc/kyc_verification_event.dart';
import '../bloc/kyc_verification_state.dart';
import '../data/form_data.dart';

class KycVerificationPage extends StatelessWidget {
  KycVerificationBloc? bloc;
  KycVerificationState? state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => KycVerificationBloc()..add(InitEvent(context)),
      child: BlocBuilder<KycVerificationBloc,KycVerificationState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, KycVerificationState state) {
    this.state ??= state;
    bloc ??= BlocProvider.of<KycVerificationBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).kyc_form),
      body: Form(
        key: bloc!.formKey,
        child: mainView(context,state)
      ),
    );
  }

  Widget mainView(BuildContext context,KycVerificationState state) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 16.r,right: 16.r),
      children: [
        16.verticalSpace,
        if(state.auth!.response!.user!.kycStatus == "3")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLanguage(context).kyc_rejection_message(state.auth!.response!.user!.kycRejectReason ?? ''),
                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                  color: AppColor.red
                ),
              ),
              16.verticalSpace
            ],
          ),
        state.formData != null ?
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.formData?.response?.data?.length ?? 0,
          itemBuilder: (ctx,index){
            DynamicForm field = state.formData!.response!.data![index];
            return field.isTextField! ? Container(
              margin: EdgeInsets.only(bottom: 10.r),
              child: DefaultTextField(
                controller: field.controller!,
                label: field.label!.capitalize,
                textInputType: getTextInputType(field.type!),
                enableValidation: field.required!,
                isRequired: field.required!,
              ),
            ) : filePicker(field,context,index);
          }
        ) : CircularProgress(height: 0.2.sh),
        10.verticalSpace,
        DefaultButton(
          onTap: ()=> bloc!.add(SubmitLoanRequest()),
          enable: state.formData!=null,
          isLoading: state.loading,
          child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
        )
      ],
    );
  }

  Widget singleData({required String title,required String data,required BuildContext context}){
    return DividerList(
      padding: EdgeInsets.symmetric(vertical: 12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)),
          Text(data,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)
        ],
      ),
    );
  }

  TextInputType getTextInputType(String type) {
    switch(type.toLowerCase()){
      case '3' :
        return TextInputType.text;
      case '1':
        return TextInputType.number;
      default :
        return TextInputType.text;
    }
  }

  Widget filePicker(DynamicForm field, BuildContext context,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text((field.label ?? '').capitalize,style: appTheme(context).textTheme.headlineMedium,),
          5.verticalSpace,
          WidgetValidation(
            crossAxisAlignment: CrossAxisAlignment.start,
            validator: (text){
              if(field.data == null){
                return '${field.label ?? ''}${appLanguage(context).required}';
              }
              return null;
            },
            borderRadius: 5.r,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.textFieldBackground,
                borderRadius: BorderRadius.circular(5.r)
              ),
              padding: EdgeInsets.all(10.r),
              child: Row(
                children: [
                  Expanded(
                    child: field.data!=null ? Image.file(field.data,height: 100.h,width: 100.h,) :
                        Assets.images.empty.image(height: 100.h,width: 100.h,),
                  ),
                  IconButton(
                    onPressed: () async {
                      var image = await getImage();
                      if(image!=null){
                        bloc!.add(AddFile(image,index));
                      }
                    },
                    icon: Icon(Icons.camera_alt,color: AppColor.iconColor,)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
