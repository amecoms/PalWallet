import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../main.dart';
import '../Widgets/show_message.dart';
import '../controllers/connnectivity_helper.dart';
import '../controllers/share_helper.dart';
import '../data/auth.dart';
import '../utils/app_constant.dart';

enum Method { POST, GET,PUT,DELETE,PATCH }



class ApiClient{
  List<http.Client> clients = [];

  Map<String,String> headerWithAuth(Auth auth) => {
    "Accept": "application/json",
    'Authorization':'Bearer ${auth.response?.token ?? ''}'
  };

  Map<String,String> headerWithoutAuth() => {
    "Accept": "application/json",
  };


  void close(){
    for(int i=0; i<clients.length;i++){
      clients[i].close();
    }
    clients.clear();
  }

  Future Request({
    required String url,
    Method method=Method.GET,
    Map<String,dynamic>? body,
    List<String>? fileKey,
    List<File>? files,
    required Function onSuccess,
    required Function onError,
    bool enableShowError=true,
    bool forceLogout=true,
    bool withAuth=true})async{
    if(ConnectivityHelper.networkState.value == ConnectivityResult.none){
      return;
    }

    Auth? auth = Auth.getAuth();

    final client = http.Client();
    clients.add(client);

    try {
      http.Response? response;
      if(method==Method.POST) {
        response = await client.post(Uri.parse(url),body: body, headers: withAuth ? headerWithAuth(auth!) : headerWithoutAuth());
      }
      else if(method==Method.DELETE) {
        response = await client.delete(Uri.parse(url), headers: withAuth ? headerWithAuth(auth!) : headerWithoutAuth());
      }
      else if(method==Method.PATCH) {
        response = await client.patch(Uri.parse(url), headers: withAuth ? headerWithAuth(auth!) : headerWithoutAuth(),body: body);
      }
      else {
        response = await client.get(Uri.parse(url), headers: withAuth ? headerWithAuth(auth!) : headerWithoutAuth());
      }
      showData(url: url,response: response.body,body: body,method: method,header: withAuth ? headerWithAuth(auth!) : headerWithoutAuth(),statusCode: response.statusCode);
      Map data = json.decode(response.body);
      if(response.statusCode == 401){
        if(enableShowError) {
          ErrorMessage(message: appLanguage().unauthenticated);
        }
        onError(auth!.toJson());
        ShareHelper.logOut(forceLogout: forceLogout);
      } else if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 422 || response.statusCode == 400 || response.statusCode == 404) {
        try{
          try {
            if (data.containsKey(AppConstant.success) && data[AppConstant.success] == true) {
              onSuccess(data);
            } else {
              if(data['response'].runtimeType == List<dynamic>){
                if (enableShowError) ErrorMessage(message: data['response'][0].toString());
              } else {
                Map response = data['response'];
                if (response.isNotEmpty) {
                  String message = '';
                  response.forEach((key, value) {
                    if (value.runtimeType == List<dynamic>) {
                      message = value[0].toString();
                    } else {
                      message = value.toString();
                    }
                  });
                  if (enableShowError) ErrorMessage(message: message);
                } else {
                  if (enableShowError) ErrorMessage(message: data['message'] ?? appLanguage().somethingWentWrong);
                }
              }
              onError(data);
            }
          } on Error catch (e){
            log(e.toString(),stackTrace: e.stackTrace);
            if (enableShowError) {
              ErrorMessage(message: appLanguage().somethingWentWrong);
            }
            onError(data);
          }
        } on Error catch (e) {
          log('Error = ${e.toString()}');
          log('Error = ${e.stackTrace}');
          if(enableShowError) {
            ErrorMessage(message: appLanguage().somethingWentWrong);
          }
          onError(data);
        }
      } else {
        var data = json.decode(response.body);
        if(enableShowError) {
          ErrorMessage(message: data['message'] ?? appLanguage().somethingWentWrong);
        }
        onError({'error': data['message'] ?? appLanguage().somethingWentWrong});
      }
    } on http.ClientException catch (e) {
      //Client Error = ClientException / true / Connection closed before full header was received
      //Client Error = _ClientSocketException / true / Failed host lookup:
      log('Client Error = ${e.message}');
      if(enableShowError && e.runtimeType.toString() == '_ClientSocketException') {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    } on TimeoutException catch (e) {
      log('TimeoutException Error = ${e.message}');
      if(enableShowError) {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    } on SocketException catch (e) {
      log('SocketException Error = ${e.message}');
      if(enableShowError) {
        ErrorMessage(message: appLanguage().somethingWentWrong);
      }
      onError({'error': appLanguage().somethingWentWrong});
    } on Error catch (e) {
      log('Error = ${e.toString()}',stackTrace: e.stackTrace);
      if(enableShowError) {
        ErrorMessage(message: appLanguage().somethingWentWrong);
      }
      onError({'error': appLanguage().somethingWentWrong});
    }
  }

  String getMethodName(Method method){
    switch(method) {
      case Method.PATCH:
        return 'PATCH';
      case Method.POST:
        return 'POST';
      default:
        return 'POST';
    }
  }

  Future RequestWithFile({
    required String url,
    Map<String,String>? body,
    required List<String> fileKey,
    required List<File> files,
    Method method=Method.POST,
    required Function onSuccess,
    required Function onError,
    bool enableShowError=true,
    bool withAuth= true,
    bool forceLogout = true
  }) async {
    var result;
    var uri = Uri.parse(url);
    http.MultipartRequest? request;

    Auth? auth = Auth.getAuth();

    request = http.MultipartRequest(getMethodName(method), uri)..fields.addAll(body!)..headers.addAll(withAuth ? headerWithAuth(auth!) : headerWithoutAuth());

    for(int i=0;i<fileKey.length;i++){
      var stream = http.ByteStream(files[i].openRead().cast());
      var length = await files[i].length();
      var multipartFile = http.MultipartFile(fileKey[i], stream, length, filename: basename(files[i].path));
      request.files.add(multipartFile);
    }
    http.StreamedResponse? response;
    try {
      response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        result = value;

        showData(body: body,method: method,response: result,url: url,header: withAuth ? headerWithAuth(auth!) : headerWithoutAuth(),statusCode: response!.statusCode);
        Map data=json.decode(result);
        if(response.statusCode == 401){
          if(enableShowError) {
            ErrorMessage(message: appLanguage().unauthenticated);
          }
          onError(auth!.toJson());
          ShareHelper.logOut(forceLogout: forceLogout);
        } else if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 422 || response.statusCode == 400 || response.statusCode == 404) {
          try{
            try {
              if (data.containsKey(AppConstant.success) && data[AppConstant.success] == true) {
                onSuccess(data);
              } else {
                if(data['response'].runtimeType == List<dynamic>){
                  if (enableShowError) ErrorMessage(message: data['response'][0].toString());
                } else {
                  Map response = data['response'];
                  if (response.isNotEmpty) {
                    String message = '';
                    response.forEach((key, value) {
                      if (value.runtimeType == List<dynamic>) {
                        message = value[0].toString();
                      } else {
                        message = value.toString();
                      }
                    });
                    if (enableShowError) ErrorMessage(message: message);
                  } else {
                    if (enableShowError) ErrorMessage(message: data['message'] ?? appLanguage().somethingWentWrong);
                  }
                }
                onError(data);
              }
            } on Error catch (e){
              log(e.toString(),stackTrace: e.stackTrace);
              if (enableShowError) {
                ErrorMessage(message: appLanguage().somethingWentWrong);
              }
              onError(data);
            }
          } on Error catch (e) {
            log('Error = ${e.toString()}');
            log('Error = ${e.stackTrace}');
            if(enableShowError) {
              ErrorMessage(message: appLanguage().somethingWentWrong);
            }
            onError(data);
          }
        } else {
          if(enableShowError) {
            ErrorMessage(message: data['message'] ?? appLanguage().somethingWentWrong);
          }
          onError({'error': data['message'] ?? appLanguage().somethingWentWrong});
        }
      });
    } on http.ClientException catch (e) {
      //Client Error = ClientException / true / Connection closed before full header was received
      //Client Error = _ClientSocketException / true / Failed host lookup:
      log('Client Error = ${e.message}');
      if(enableShowError && e.runtimeType.toString() == '_ClientSocketException') {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    } on TimeoutException catch (e) {
      log(e.message ?? '');
      if(enableShowError) {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    } on SocketException catch (e) {
      log(e.message);
      if(enableShowError) {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    } on Error catch (e) {
      log(e.toString(),stackTrace: e.stackTrace);
      if(enableShowError) {
        ErrorMessage(message: appLanguage().checkYourInternetConnection);
      }
      onError({'error': appLanguage().checkYourInternetConnection});
    }
  }





  void showData({required String url, dynamic body,required dynamic header,required dynamic statusCode, required dynamic response,required dynamic method}) {
    if (kDebugMode) {
      log("URL = $url");
      log("Body = $body");
      log("Header = $header");
      log("Status Code = $statusCode");
      log("Method = $method");
      log("Response = $response");
    }
  }

}
