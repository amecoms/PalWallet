import 'package:flutter/material.dart';

abstract class SupportDetailsEvent {}

class InitEvent extends SupportDetailsEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetReply extends SupportDetailsEvent {}
class DownloadFile extends SupportDetailsEvent {
  String url;

  DownloadFile(this.url);
}
class AttachFile extends SupportDetailsEvent {}
class SendMessageEvent extends SupportDetailsEvent {}