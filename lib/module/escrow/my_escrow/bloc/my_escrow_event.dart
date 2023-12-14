

abstract class MyEscrowEvent {}

class InitEvent extends MyEscrowEvent {}
class GetData extends MyEscrowEvent {}
class ReleaseEscrow extends MyEscrowEvent {
  int index;
  ReleaseEscrow(this.index);
}