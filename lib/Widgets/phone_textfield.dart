import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/default_textfield.dart';
import '../main.dart';
import '../theme/app_color.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../utils/dimension.dart';


Widget PhoneTextField({required PhoneController controller,FocusNode? focusNode,String? label,Widget? prefixIcon,Widget? suffixIcon,
  int maxLine=1,String? hint,bool isRequired=false,bool enable = true,bool borderEnable = true,Color? backgroundColor,
  double? borderRadius,bool labelAsTitle=false,TextAlign textAlign=TextAlign.left,bool autofocus=false,EdgeInsets? contentPadding,Color? borderColor,bool enableValidation=true,List<TextInputFormatter>? inputFormatters,
  FormFieldValidator<String>? validator,bool isLabelUpperCase=false,bool enabled=true,EdgeInsetsGeometry? labelPadding,TextStyle? labelStyle}){

  return Theme(
    data: Theme.of(appContext).copyWith(
      textTheme: Theme.of(appContext).textTheme.copyWith(
        subtitle1: appTheme().textTheme.headline1!.copyWith(fontSize: 16.spMin,fontWeight: Dimension.textMedium),
        bodyText2: appTheme().textTheme.bodyText1!.copyWith(fontWeight: Dimension.textRegular),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: labelAsTitle,
            child: Padding(
              padding: labelPadding ?? EdgeInsets.only(bottom: 10.r),
              child: Text(
                label != null ? '${isLabelUpperCase ? label.toUpperCase() : label}${isRequired ? '*' : ''}' : '',
                style: labelStyle ?? appTheme().textTheme.bodyText1,
              ),
            )),
        PhoneFormField(
          controller: controller,
          initialValue: null,
          shouldFormat: true,
          focusNode: focusNode,
          autocorrect: false,
          cursorColor: AppColor.primary,
          autofocus: autofocus,
          textAlign: textAlign,
          enabled: enabled,
          textInputAction: TextInputAction.done,
          inputFormatters: inputFormatters,
          style: appTheme().textTheme.bodyText1!.copyWith(fontSize: 16.spMin,fontWeight: Dimension.textRegular),
          countryCodeStyle: appTheme().textTheme.bodyText1!.copyWith(fontSize: 16.spMin,fontWeight: Dimension.textRegular),
          decoration: InputDecoration(
              filled: true,
              contentPadding: contentPadding ?? (!borderEnable ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16.r,vertical: 16.r)),
              fillColor: enable ? backgroundColor ?? (!borderEnable ? AppColor.textFieldBackground : AppColor.textFieldBackground ) : Colors.transparent,
              enabledBorder: borderEnable ? textFieldBorder(borderRadius: borderRadius ?? 5.r,borderColor: borderColor) : roundedBorder(),
              focusedBorder: borderEnable ? textFieldBorder(borderRadius: borderRadius ?? 5.r,borderColor: borderColor) : roundedBorder(color: AppColor.primary2),
              errorBorder: borderEnable ? textFieldBorder(isError: true,borderRadius: borderRadius ?? 5.r,borderColor: borderColor) : roundedBorder(color: AppColor.red),
              disabledBorder:  borderEnable ? textFieldBorder(borderRadius: borderRadius ?? 5.r,borderColor: borderColor) : roundedBorder(),
              border: borderEnable ? textFieldBorder(borderRadius: borderRadius ?? 5.r,borderColor: borderColor) : roundedBorder(),
              labelText: labelAsTitle ? null : label!=null ? '$label${isRequired ? '*' : ''}' : null,
              labelStyle: labelStyle ?? appTheme().textTheme.bodyText1!.copyWith(color: AppColor.textColor,fontSize: 14.sp,fontWeight: Dimension.textRegular),
              prefixIcon: prefixIcon,
              errorStyle: appTheme().textTheme.bodyText1!.copyWith(fontSize: 10.spMin,color: AppColor.red),
              hintText: hint,
              hintStyle: appTheme().textTheme.bodyText1!.copyWith(color: AppColor.grey,fontSize: 14.spMin,fontWeight: Dimension.textRegular)
          ),
          validator: PhoneValidator.validMobile(),   // default PhoneValidator.valid()
          countrySelectorNavigator: const CountrySelectorNavigator.draggableBottomSheet(),
          showFlagInInput: true,  // default
          flagSize: 16,           // default
          autofillHints: const [AutofillHints.telephoneNumber], // default to null
          autovalidateMode: AutovalidateMode.onUserInteraction, // default
        ),
      ],
    ),
  );
}