import 'dart:io';

import 'package:genius_wallet/module/escrow/escrow_dispute/data/escrow_dispute.dart';

import '../../../../app_helper/enums.dart';
import '../../../../data/auth.dart';
class EscrowDisputeState {
  PageState pageState;
  String? channelId;
  EscrowDispute? messages;
  Auth? auth = Auth.getAuth();
  File? messageFile;


  EscrowDisputeState({this.pageState = PageState.Initial, this.channelId, this.messages, this.messageFile});

  EscrowDisputeState init() {
    return EscrowDisputeState();
  }

  EscrowDisputeState clone({PageState? pageState, String? channelId, EscrowDispute? messages, File? messageFile}) {
    return EscrowDisputeState(
      channelId: channelId ?? this.channelId,
      pageState: pageState ?? this.pageState,
      messages: messages ?? this.messages,
      messageFile: messageFile ?? this.messageFile
    );
  }
}
