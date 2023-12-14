import 'dart:io';

import 'package:genius_wallet/data/settings.dart';
import 'package:genius_wallet/module/qr_code/data/qr_data.dart';

import '../app_helper/api_client.dart';
import '../config/dependency.dart';
import '../controllers/share_helper.dart';
import '../data/auth.dart';
import '../module/kyc_verification/data/form_data.dart';
import '../module/two_fa_verification/data/two_fa_code.dart';
import '../utils/url.dart';

import '../data/user.dart';

class UserRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getUser({required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true,bool forceLogout = true}) async {
    await apiClient.Request(
        url: URL.user,
        enableShowError: enableShowError,
        forceLogout: forceLogout,
        onSuccess: (Map<String,dynamic> data) {
          User user = User.fromJson(data['response']['user']);
          Auth? auth = Auth.getAuth();
          auth!.response!.user = user;
          ShareHelper.setAuth(auth);
          onSuccess(auth);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }


  Future getQrCode({required Function(QrData) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true,bool forceLogout = true}) async {
    await apiClient.Request(
        url: URL.generateQr,
        enableShowError: enableShowError,
        forceLogout: forceLogout,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(QrData.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }


  Future getSettings({required Function(Settings) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true,bool forceLogout = true}) async {
    await apiClient.Request(
        url: URL.settings,
        enableShowError: enableShowError,
        forceLogout: forceLogout,
        onSuccess: (Map<String,dynamic> data) {
          Settings st = Settings.fromJson(data);
          instance.registerSingleton<Settings>(st);
          onSuccess(st);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }




  Future changePassword({required Map<String,String> body, required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.changePassword,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: (Map<String,dynamic> data) {
        onError(data);
      }
    );
  }



  Future updateProfile({required Map<String,String> body,required List<File> files,required List<String> fileKey, required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.RequestWithFile(
        url: URL.updateProfile,
        method: Method.POST,
        body: body,
        files: files,
        fileKey: fileKey,
        onSuccess: (Map<String,dynamic> data) {
          User user = User.fromJson(data['response']);
          Auth? auth = Auth.getAuth();
          auth!.response!.user = user;
          instance.registerSingleton<Auth>(auth);
          onSuccess(Auth.getAuth()!);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getKycForm({required Function(FormData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.kycForm,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(FormData.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future sendTwoFaCode({required Map<String, String> body,bool isResend = false ,required Function(TwoFaCode) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: isResend ? URL.resendCode : URL.sendCode,
        method: isResend ? Method.GET : Method.POST,
        body: body,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(TwoFaCode.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future changeTwoFaState({required String url, required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: url,
        method: Method.POST,
        body: body,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future submitKyc({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
    List<File> files = const [],
    List<String> fileKeys = const [],
  }) async {
    await apiClient.RequestWithFile(
        url: URL.kycFormSubmit,
        body: body,
        method: Method.POST,
        files: files,
        fileKey: fileKeys,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(data);
        },
        onError: onError
    );
  }
}