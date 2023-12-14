
import 'package:genius_wallet/data/auth.dart';

import '../data/form_data.dart';

class KycVerificationState {
  FormData? formData;
  bool loading;
  Auth? auth = Auth.getAuth();


  KycVerificationState({this.formData,this.loading = false});

  KycVerificationState init() {
    return KycVerificationState();
  }

  KycVerificationState clone({FormData? formData,bool? loading}) {
    return KycVerificationState(
      formData: formData ?? this.formData,
      loading: loading ?? this.loading
    );
  }
}
