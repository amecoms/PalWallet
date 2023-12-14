import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/network_image.dart';
import 'package:genius_wallet/main.dart';

import 'qr_code_bloc.dart';
import 'qr_code_event.dart';
import 'qr_code_state.dart';

class QrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QrCodeBloc()..add(InitEvent()),
      child: BlocBuilder<QrCodeBloc, QrCodeState>(builder: (context, state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, QrCodeState state) {
    final bloc = BlocProvider.of<QrCodeBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).qr_code,
      ),
      body: Center(
        child: state.qrData != null ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedImage(
              imageUrl: state.qrData!.response!.qrcodeImage,
            ),
            16.verticalSpace,
            Text(
              state.auth!.response!.user!.email ?? '',
              style: appTheme(context).textTheme.headlineLarge,
            )
          ],
        ) : CircularProgress(),
      ),
    );
  }
}

