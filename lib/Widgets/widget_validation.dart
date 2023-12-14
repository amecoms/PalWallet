import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import '../theme/app_color.dart';
class WidgetValidation extends StatelessWidget {
  WidgetValidation({
    Key? key,
    required this.validator,
    required this.child,
    this.color,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);
  final String? Function(dynamic) validator;
  Widget child;
  Color? color;
  double? borderRadius;
  MainAxisAlignment mainAxisAlignment;
  MainAxisSize mainAxisSize;
  CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator,
        builder: (formFieldState) {
          return Column(
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              child,
              if (formFieldState.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 8.r,left: 16.r),
                  child: Text(
                    formFieldState.errorText!,
                    style: appTheme(context).textTheme.bodySmall!.copyWith(color: AppColor.red),
                  ),
                )
            ],
          );
        }
    );
  }
}