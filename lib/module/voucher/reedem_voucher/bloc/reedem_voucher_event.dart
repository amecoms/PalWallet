import '../data/voucher_data.dart';

abstract class ReedemVoucherEvent {}

class InitEvent extends ReedemVoucherEvent {}
class SubmitTransfer extends ReedemVoucherEvent {}