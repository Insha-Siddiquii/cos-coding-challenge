// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/http/user.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/change_password/model/password.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:formz/formz.dart';

part 'changepaswd_event.dart';
part 'changepaswd_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required RemoteAuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ChangePasswordState()) {
    on<ChangePasswordChanged>(_mapPasswordChangedToState);
    on<ChangePasswordSubmit>(_mapChangePasswordSubmit);
    on<ChangePasswordConfirmChanged>(_mapChangePasswordConfirm);
  }
  final RemoteAuthRepository _authenticationRepository;
  _mapPasswordChangedToState(
    ChangePasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final password = Password.dirty(event.password);

    return emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.confirmPassword]),
    ));
  }

  _mapChangePasswordConfirm(
    ChangePasswordConfirmChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final cPassword = Password.dirty(event.confirmPassword);
    return emit(state.copyWith(
      confirmPassword: cPassword,
      status: Formz.validate([cPassword, state.confirmPassword]),
    ));
  }

  Future<void> _mapChangePasswordSubmit(
    ChangePasswordSubmit event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await UserProfileServices().changeUserPassword(
          UserEditModel().getUserEmail(),
          state.confirmPassword.value,
          state.confirmPassword.value,
        );
        emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        );
        Future.delayed(const Duration(seconds: 3), () {
          _authenticationRepository.logOut();
        });
      } on Exception catch (_) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }
}
