

import 'package:genius_wallet/data/auth.dart';
import 'package:genius_wallet/data/settings.dart';

class SettingsState {
  Auth? auth = Auth.getAuth();
  Settings? settings = Settings.getSettings();


  SettingsState({this.auth});

  SettingsState init() {
    return SettingsState(
      auth: Auth.getAuth()
    );
  }

  SettingsState clone({Auth? auth}) {
    return SettingsState(
      auth: auth ?? this.auth
    );
  }
}
