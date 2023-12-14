abstract class ChangePasswordEvent {}

class InitEvent extends ChangePasswordEvent {}
class SubmitEvent extends ChangePasswordEvent {}