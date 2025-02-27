// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:flutter_cos_app/ui/login/model/password.dart';
import 'package:flutter_cos_app/ui/login/model/useremail.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required RemoteAuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUseremailChanged>(_mapUsernameChangedToState);
    on<LoginPasswordChanged>(_mapPasswordChangedToState);
    on<LoginWithCredentials>(_mapLoginWithCredentials);
    on<LoginWithGoogle>(_mapLoginWithGoogle);
    on<LogOut>(_mapLogout);
  }

  final RemoteAuthRepository _authenticationRepository;

  _mapUsernameChangedToState(
    LoginUseremailChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Useremail.dirty(event.useremail);
    return emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  _mapPasswordChangedToState(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    return emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.useremail]),
    ));
  }

  Future<void> _mapLoginWithCredentials(
    LoginWithCredentials event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress, errorMsg: ''));
      try {
        UserEditModel().setUserEmail(state.useremail.value);

        await _authenticationRepository.logInWithCredentials(
          useremail: state.useremail.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMsg: e.toString().replaceAll('Exception:', '')));
      }
    }
  }

  Future<void> _mapLoginWithGoogle(
    LoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(googleLoader: true, errorMsg: ''));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(googleLoader: false));
    } catch (e) {
      emit(state.copyWith(
        googleLoader: false,
        status: FormzStatus.submissionFailure,
        errorMsg: e.toString().replaceAll('Exception:', ''),
      ));
    }
  }

  _mapLogout(LogOut event, Emitter<LoginState> emit) async {
    UserEditModel().removeUserInfo();
    _authenticationRepository.logOut();
  }
}
