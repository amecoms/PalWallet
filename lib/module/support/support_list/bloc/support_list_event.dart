

abstract class SupportListEvent {}

class InitEvent extends SupportListEvent {}
class GetData extends SupportListEvent {}
class OpenTicket extends SupportListEvent {
  String subject;

  OpenTicket(this.subject);
}