import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../config/dependency.dart';
import '../data/auth.dart';
import '../gen/assets.gen.dart';
import '../main.dart';
import '../theme/app_color.dart';
import '../utils/dimension.dart';


Widget ImagePlaceHolder({double? height,double? width,BoxFit? fit}){
  return Container(
    color: AppColor.buttonTextColor,
    child: Assets.images.empty.image(fit: fit ?? BoxFit.cover,height: height,width: width,),
  );
}
Widget UserImagePlaceHolder({required double height,BoxFit? fit,double? width, String? name, Color? color, double? borderRadius}){
  Auth? user;
  try{
    user = instance.get<Auth>();
  }catch(e){}
  return Container(
    color: Colors.transparent,
    child: user!=null || name!=null ? Avatar(
      name: (name ?? "${user?.response?.user?.name}").trim(),
      placeholderColors: (color != null) ? [color] : const [
        Color(0xff51D887),
        Color(0xff9C51D8),
        Color(0xffF6E122),
        Color(0xff4D7CF5),
        Color(0xffFD8856),
        Color(0xffD663FE),
        Color(0xffED308B),
        Color(0xffC2EE44),
        Color(0xff51D887),
      ],
      textStyle: appTheme().textTheme.headlineLarge!.copyWith(
          fontWeight: Dimension.textSemiBold,
          color: (color == null) ? AppColor.white : Colors.black
      ),
      shape: borderRadius==null ? AvatarShape.circle(height/2,) : AvatarShape.rectangle(
          width ?? height,
          height,
          BorderRadius.circular(borderRadius)
      ),
    ) :  Assets.images.user.svg(height: height,width: width??height,fit: fit ?? BoxFit.none,),
  );
}