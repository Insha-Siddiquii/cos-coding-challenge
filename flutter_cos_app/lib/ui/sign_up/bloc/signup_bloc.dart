// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:flutter_cos_app/ui/sign_up/model/password.dart';
import 'package:flutter_cos_app/ui/sign_up/model/useremail.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required RemoteAuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpUseremailChanged>(_mapUsernameChangedToState);
    on<SignUpPasswordChanged>(_mapPasswordChangedToState);
    on<SignUpWithCredentials>(_mapSignUpWithCredentials);
  }

  final RemoteAuthRepository _authenticationRepository;

  _mapUsernameChangedToState(
    SignUpUseremailChanged event,
    Emitter<SignUpState> emit,
  ) {
    final username = Useremail.dirty(event.useremail);
    return emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  _mapPasswordChangedToState(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = Password.dirty(event.password);

    return emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.useremail]),
    ));
  }

  Future<void> _mapSignUpWithCredentials(
    SignUpWithCredentials event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        UserEditModel().setUserEmail(state.useremail.value);

        await _authenticationRepository.signUpWithCredentials(
          useremail: state.useremail.value,
          password: state.password.value,
        );
        emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        );
      } catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMsg: e.toString().replaceAll('Exception:', '')));
      }
    }
  }
}
