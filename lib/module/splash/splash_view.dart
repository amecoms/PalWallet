import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Widgets/app_background.dart';
import '../../../../gen/assets.gen.dart';

import '../../theme/app_color.dart';
import 'splash_bloc.dart';
import 'splash_event.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc()..add(InitSplashEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SplashBloc>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.spashScreen.keyName),
            fit: BoxFit.cover
          )
        ),
        alignment:Alignment.center,
        child: Assets.banner.image(color: AppColor.white,width: 0.8.sw, height: 69.h),
      ),
    );
  }
}

