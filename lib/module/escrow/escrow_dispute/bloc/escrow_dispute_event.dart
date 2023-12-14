import 'package:flutter/material.dart';

abstract class EscrowDisputeEvent {}

class InitEvent extends EscrowDisputeEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetReply extends EscrowDisputeEvent {}
class DownloadFile extends EscrowDisputeEvent {
  String url;

  DownloadFile(this.url);
}
class AttachFile extends EscrowDisputeEvent {}
class SendMessageEvent extends EscrowDisputeEvent {}