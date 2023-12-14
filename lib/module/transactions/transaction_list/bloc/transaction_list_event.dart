

abstract class TransactionListEvent {}

class InitEvent extends TransactionListEvent {}
class ChangeFilter extends TransactionListEvent {
  String? remark,trxId;
  ChangeFilter(this.remark, this.trxId);
}
class GetData extends TransactionListEvent {}