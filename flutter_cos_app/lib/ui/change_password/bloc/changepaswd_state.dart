part of 'changepaswd_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState(
      {this.status = FormzStatus.pure,
      this.password = const Password.pure(),
      this.confirmPassword = const Password.pure(),
      this.submitloader = false});

  final FormzStatus status;
  final Password password;
  final Password confirmPassword;
  final bool submitloader;

  ChangePasswordState copyWith({
    FormzStatus? status,
    Password? password,
    Password? confirmPassword,
    bool? submitloader,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submitloader: submitloader ?? this.submitloader,
    );
  }

  @override
  List<Object> get props => [status, password, submitloader, confirmPassword];
}
