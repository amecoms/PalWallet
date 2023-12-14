import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityHelper{
  late StreamSubscription<ConnectivityResult> subscription;
  StreamSubscription<ConnectivityResult>? subscription2;
  static ValueNotifier<ConnectivityResult> networkState = ValueNotifier<ConnectivityResult>(ConnectivityResult.wifi);


  ConnectivityHelper(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      log("Connectivity status = ${result.name}");
      networkState.value = result;
    });
  }

  ConnectivityHelper.listen({required Function(bool) listen}){
    subscription2 = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      listen(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile);
    });
  }

  // This method is important for ConnectivityHelper.listen()
  // When use ConnectivityHelper.listen() then must call this method inside onClose() lifecycle method
  ConnectivityHelper.closeListen(){
    subscription2?.cancel();
  }
}
