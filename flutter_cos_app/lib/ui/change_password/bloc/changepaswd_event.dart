part of 'changepaswd_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordChanged extends ChangePasswordEvent {
  const ChangePasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ChangePasswordConfirmChanged extends ChangePasswordEvent {
  const ChangePasswordConfirmChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class ChangePasswordSubmit extends ChangePasswordEvent {
  const ChangePasswordSubmit();
}
