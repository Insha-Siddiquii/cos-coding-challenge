// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required RemoteAuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );

    _googleInfoSubscription = _authenticationRepository.googleUserInfo
        .listen((value) => add(AuthenticationGoogleInfo(value)));

    on<AuthenticationStatusChanged>(_mapAuthenticationStatusChangedToState);
    on<AuthenticationGoogleInfo>(_fetchUserGoogleInfo);
  }

  final RemoteAuthRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  late StreamSubscription<String> _googleInfoSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _googleInfoSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(const AuthenticationState.authenticated());

      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  _fetchUserGoogleInfo(
    AuthenticationGoogleInfo event,
    Emitter<AuthenticationState> emit,
  ) async {
    UserEditModel().setUserEmail(event.email);
  }
}
