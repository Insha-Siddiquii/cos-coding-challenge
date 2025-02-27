part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState(
      {this.status = FormzStatus.pure,
      this.useremail = const Useremail.pure(),
      this.password = const Password.pure(),
      this.googleLoader = false,
      this.errorMsg = ''});

  final FormzStatus status;
  final Useremail useremail;
  final Password password;
  final bool googleLoader;
  final String errorMsg;

  SignUpState copyWith({
    FormzStatus? status,
    Useremail? username,
    Password? password,
    bool? googleLoader,
    String? errorMsg,
  }) {
    return SignUpState(
      status: status ?? this.status,
      useremail: username ?? useremail,
      password: password ?? this.password,
      googleLoader: googleLoader ?? this.googleLoader,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props =>
      [status, useremail, password, googleLoader, errorMsg];
}
