

import '../data/request_list.dart';

abstract class ReceivedRequestListEvent {}

class InitEvent extends ReceivedRequestListEvent {}
class GetData extends ReceivedRequestListEvent {}
class ChangeStatus extends ReceivedRequestListEvent {
  RequestData data;
  int index;
  bool isApproved;

  ChangeStatus(this.data, this.index, this.isApproved);
}