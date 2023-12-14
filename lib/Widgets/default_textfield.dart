import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import '../theme/app_color.dart';
import '../utils/dimension.dart';

import '../../main.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField(
      {required this.controller,
        this.focusNode,
        this.label,
        this.backgroundColor,
        this.prefixIcon,
        this.suffixIcon,
        this.suffix,
        this.maxLine = 1,
        this.textInputType = TextInputType.text,
        this.obscureText = false,
        this.hint,
        this.enable = true,
        this.onTap,
        this.isRequired = false,
        this.borderEnable = true,
        this.borderRadius,
        this.labelAsTitle = false,
        this.textAlign = TextAlign.left,
        this.autofocus = false,
        this.contentPadding,
        this.borderColor,
        this.enableValidation = true,
        this.inputFormatters,
        this.validator,
        this.isLabelUpperCase = false,
        this.labelPadding,
        this.autovalidateMode,
        this.enableScanEmail = false,
        this.labelStyle});
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? label;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int maxLine;
  final TextInputType textInputType;
  final bool obscureText;
  final String? hint;
  final bool enable;
  final GestureTapCallback? onTap;
  final bool isRequired;
  final bool borderEnable;
  final double? borderRadius;
  final bool labelAsTitle;
  final TextAlign textAlign;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final bool enableValidation;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool isLabelUpperCase;
  final bool enableScanEmail;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelStyle;
  final AutovalidateMode? autovalidateMode;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> with AutomaticKeepAliveClientMixin{
  final ValueNotifier<bool> suffixVisibility = ValueNotifier(false);
  @override
  void initState() {
    suffixVisibility.value = widget.obscureText;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
            visible: widget.labelAsTitle,
            child: Padding(
              padding: widget.labelPadding ?? EdgeInsets.only(bottom: 6.r),
              child: Text(
                widget.label != null ? '${widget.isLabelUpperCase ? widget.label?.toUpperCase() : widget.label}${widget.isRequired ? '*' : ''}' : '',
                style: widget.labelStyle ?? appTheme().textTheme.bodyLarge
              ),
            )),
        GestureDetector(
          onTap: widget.onTap,
          child: AbsorbPointer(
            absorbing: widget.onTap != null,
            child: ValueListenableBuilder<bool>(
              valueListenable: suffixVisibility,
              builder: (context, value, child) {
                return TextFormField(
                  style: appTheme()
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: widget.enable ? AppColor.textColor : AppColor.grey, fontSize: 16.sp),
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  autovalidateMode: widget.autovalidateMode,
                  autocorrect: false,
                  keyboardType: widget.textInputType,
                  cursorColor: AppColor.primary,
                  autofocus: widget.autofocus,
                  maxLines: widget.maxLine,
                  enabled: widget.enable,
                  obscureText: value,
                  enableSuggestions: false,
                  obscuringCharacter: '＊',
                  textAlign: widget.textAlign,
                  textInputAction: TextInputAction.done,
                  inputFormatters: widget.inputFormatters,
                  /*
                    textInputType: TextInputType.numberWithOptions(decimal: true,),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  */
                  validator: widget.enableValidation
                      ? widget.validator ??
                          (String? value) {
                        if (value == null || value.isEmpty) {
                          if (widget.focusNode != null) {
                            widget.focusNode?.requestFocus();
                          }
                          return widget.label != null
                              ? '${widget.label}${appLanguage().required}'
                              : appLanguage().required.replaceAll(appLanguage().required.split(' ')[1], '');
                        } else {
                          return null;
                        }
                      }
                      : null,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: widget.contentPadding ?? (!widget.borderEnable ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r)),
                      fillColor: widget.enable
                          ? widget.backgroundColor ?? (!widget.borderEnable ? AppColor.textFieldBackground : AppColor.textFieldBackground)
                          : Colors.transparent,
                      enabledBorder: widget.borderEnable ? textFieldBorder(borderRadius: widget.borderRadius ?? 8.r, borderColor: widget.borderColor) : roundedBorder(),
                      focusedBorder: widget.borderEnable
                          ? textFieldBorder(borderRadius: widget.borderRadius ?? 8.r, borderColor: widget.borderColor)
                          : roundedBorder(color: AppColor.primary2),
                      errorBorder: widget.borderEnable
                          ? textFieldBorder(isError: true, borderRadius: widget.borderRadius ?? 8.r, borderColor: widget.borderColor)
                          : roundedBorder(color: AppColor.red),
                      disabledBorder: widget.borderEnable ? textFieldBorder(borderRadius: widget.borderRadius ?? 8.r, borderColor: widget.borderColor) : roundedBorder(),
                      border: widget.borderEnable ? textFieldBorder(borderRadius: widget.borderRadius ?? 8.r, borderColor: widget.borderColor) : roundedBorder(),
                      labelText: widget.labelAsTitle
                          ? null
                          : widget.label != null
                          ? '${widget.label}${widget.isRequired ? '*' : ''}'
                          : null,
                      labelStyle: widget.labelStyle ??
                          appTheme().textTheme.bodyLarge!.copyWith(color: AppColor.textColor, fontSize: 16.spMin, fontWeight: Dimension.textRegular),
                      errorStyle: appTheme().textTheme.bodyLarge!.copyWith(fontSize: 10.spMin, color: AppColor.red),
                      suffixIcon: widget.obscureText
                          ? InkWell(
                          onTap: () => suffixVisibility.value = !suffixVisibility.value,
                          borderRadius: BorderRadius.circular(30.r),
                          child: Icon(
                            value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColor.grey,
                          )) : widget.enableScanEmail ? InkWell(
                          onTap: scanEmailFromQr,
                          borderRadius: BorderRadius.circular(30.r),
                          child: Icon(
                            Icons.qr_code,
                            color: AppColor.grey,
                          )) : widget.suffixIcon,
                      suffix: widget.suffix,
                      hintText: widget.hint,
                      prefixIcon: widget.prefixIcon,
                      hintStyle: appTheme().textTheme.bodyLarge!.copyWith(fontSize: 16.spMin,color: AppColor.textColor2)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future scanEmailFromQr() async {
    String? email = await goToPage(Routes.QR_SCANNER_PAGE);
    if(email != null){
      widget.controller.text = email;
    }
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

textFieldBorder({bool isError = false, double? borderRadius, Color? borderColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
    borderSide: BorderSide(width: 1, color: isError ? AppColor.red : borderColor ?? AppColor.dividerColor),
  );
}

roundedBorder({Color? color, double? borderRadius}) => OutlineInputBorder(
  borderSide: BorderSide(
    color: color ?? AppColor.dividerColor,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
);

DropDownDecoratorProps dropdownDecoration({String? label, bool borderEnable = true, EdgeInsetsGeometry? padding,String? hint, double? borderRadius}) {
  return DropDownDecoratorProps(
    baseStyle: appTheme()
        .textTheme
        .bodyLarge!
        .copyWith(color: AppColor.textColor, fontSize: 16.sp),
    dropdownSearchDecoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: AppColor.textFieldBackground,
        border: roundedBorder(borderRadius: borderRadius),
        focusedBorder: roundedBorder(borderRadius: borderRadius),
        enabledBorder: roundedBorder(borderRadius: borderRadius),
        errorBorder: roundedBorder(borderRadius: borderRadius, color: AppColor.red),
        labelStyle: appTheme().textTheme.bodyLarge!.copyWith(color: AppColor.textColor, fontSize: 16.spMin, fontWeight: Dimension.textRegular),
        hintStyle: appTheme().textTheme.bodyLarge!.copyWith(fontSize: 16.spMin,color: AppColor.textColor2),
        iconColor: AppColor.iconColor,
        suffixIconColor: AppColor.iconColor
    ),
  );
}

