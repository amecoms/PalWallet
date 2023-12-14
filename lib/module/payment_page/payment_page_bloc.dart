import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../../../../utils/app_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Widgets/default_dialog.dart';
import '../../app_helper/enums.dart';
import '../../theme/app_color.dart';
import 'payment_page_event.dart';
import 'payment_page_state.dart';

class PaymentPageBloc extends Bloc<PaymentPageEvent, PaymentPageState> {
  dynamic arguments;

  late WebViewController controller;

  PaymentPageBloc() : super(PaymentPageState().init()) {
    on<InitEvent>(_init);
    on<PageLoadEvent>(_loadPage);
  }

  void _init(InitEvent event, Emitter<PaymentPageState> emit) async {
    arguments = settings(event.context).arguments;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Print', onMessageReceived: (JavaScriptMessage message) {
        Map<String,dynamic> data=jsonDecode(message.message);
        showSuccessDialog(data);
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            add(PageLoadEvent(PageState.Loading));
          },
          onPageFinished: (String url) {
            add(PageLoadEvent(PageState.Success));
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )..loadRequest(
        Uri.parse(arguments[AppConstant.url]),
        headers: {'Authorization':'Bearer ${state.auth!.response!.token}'}
      );
    emit(state.clone(
      webUrl: arguments[AppConstant.url]
    ));
  }

  FutureOr<void> _loadPage(PageLoadEvent event, Emitter<PaymentPageState> emit) {
    emit(state.clone(pageState: event.pageState));
  }


  void showSuccessDialog(Map<String, dynamic> data) async {
    await showDialog(
        context: appContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DefaultDialog(
            barrierDismissible: false,
            title: data['status'] ? appLanguage().success : appLanguage().failed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data['data'], style: appTheme().textTheme.bodyLarge,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(appLanguage().ok, style: appTheme().textTheme.headlineSmall!.copyWith(
                          color: AppColor.green
                      ),),
                      onPressed: () {
                        backPage();
                        if (data['status']) {
                          backPage(true);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
    );
  }
}
