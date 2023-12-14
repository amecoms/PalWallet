
import '../../app_helper/enums.dart';

class ChangePasswordState {
  PageState pageState;


  ChangePasswordState({this.pageState = PageState.Initial});

  ChangePasswordState init() {
    return ChangePasswordState();
  }

  ChangePasswordState clone({PageState? pageState}) {
    return ChangePasswordState(
      pageState: pageState ?? this.pageState,
    );
  }
}
