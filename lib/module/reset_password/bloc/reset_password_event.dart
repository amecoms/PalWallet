abstract class ResetPasswordEvent {}

class InitEvent extends ResetPasswordEvent {}
class ResetEvent extends ResetPasswordEvent {}
class ResetSubmitEvent extends ResetPasswordEvent {}