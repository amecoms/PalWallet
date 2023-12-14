import 'package:genius_wallet/data/module.dart';

import '../app_helper/api_client.dart';
import '../config/dependency.dart';
import '../utils/url.dart';

class SplashRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getModuleData({required Function(Module) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.module,
        withAuth: false,
        onSuccess: (Map<String,dynamic> data) {
          Module transfers = Module.fromJson(data);
          instance.registerSingleton<Module>(transfers);
          onSuccess(transfers);
        },
        onError: onError
    );
  }
}