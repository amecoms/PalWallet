import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_dialog.dart';
import 'package:genius_wallet/Widgets/message_dialog.dart';
import 'package:genius_wallet/Widgets/show_message.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../repositories/ticket_repository.dart';

class QrScannerPage extends StatefulWidget {

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  ValueNotifier<bool> isLoading = ValueNotifier(false);


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: "QR Scan"),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: AppColor.primary,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 240.h
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (ctx, value, child){
              return Visibility(
                visible: value,
                child: CircularProgress(size: 50.h)
              );
            }
          )
        ],
      ),
    );
  }


  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      controller.pauseCamera();
      decodeQR();
    });
  }

  Future decodeQR() async {
    log("Qr data = ${result!.code}");
    if(Helper.isEmailValid(result!.code.toString())){
      backPage(result!.code);
    } else {
      await MessageDialog(title: appLanguage(context).qr_code, message: appLanguage().invalid_qr);
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}

