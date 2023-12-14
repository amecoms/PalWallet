import 'dart:io';

import '../data/support_messages.dart';

import '../../../../app_helper/enums.dart';
import '../../../../data/auth.dart';
class SupportDetailsState {
  PageState pageState;
  String? channelId;
  SupportMessages? messages;
  Auth? auth = Auth.getAuth();
  File? messageFile;


  SupportDetailsState({this.pageState = PageState.Initial, this.channelId, this.messages, this.messageFile});

  SupportDetailsState init() {
    return SupportDetailsState();
  }

  SupportDetailsState clone({PageState? pageState, String? channelId, SupportMessages? messages, File? messageFile}) {
    return SupportDetailsState(
      channelId: channelId ?? this.channelId,
      pageState: pageState ?? this.pageState,
      messages: messages ?? this.messages,
      messageFile: messageFile ?? this.messageFile
    );
  }
}
