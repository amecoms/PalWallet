import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/data/auth.dart';
import 'package:genius_wallet/module/two_fa_verification/data/two_fa_code.dart';

import '../../../data/user.dart';

class TwoFAVerificationState {
  PageState pageState;
  TwoFaCode? faData;
  User user = Auth.getAuth()!.response!.user!;
  bool verificationLoading = false;


  TwoFAVerificationState({this.pageState = PageState.Initial, this.faData,this.verificationLoading = false});

  TwoFAVerificationState init() {
    return TwoFAVerificationState();
  }

  TwoFAVerificationState clone({PageState? pageState, TwoFaCode? faData, bool? verificationLoading}) {
    return TwoFAVerificationState(
      pageState: pageState ?? this.pageState,
      faData: faData ?? this.faData,
        verificationLoading: verificationLoading ?? this.verificationLoading
    );
  }
}
