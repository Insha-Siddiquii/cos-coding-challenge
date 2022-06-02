import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/change_password/bloc/changepaswd_bloc.dart';
import 'package:formz/formz.dart';

class ConfirmPasswordButton extends StatelessWidget {
  const ConfirmPasswordButton({
    Key? key,
  }) : super(key: key);

  _triggerFieldValidation(
    ChangePasswordState state,
    BuildContext context,
  ) {
    context
        .read<ChangePasswordBloc>()
        .add(ChangePasswordChanged(state.password.value));
    context
        .read<ChangePasswordBloc>()
        .add(ChangePasswordConfirmChanged(state.confirmPassword.value));

    if (state.password.invalid ||
        state.confirmPassword.invalid ||
        (state.password.value != state.confirmPassword.value)) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(AppConstants.correctInfo),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listenWhen: (previousState, state) {
        return previousState.status != state.status;
      },
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(AppConstants.changePswdSuccess),
              ),
            );
        } else if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(AppConstants.unableToChangePswd),
              ),
            );
        }
      },
      builder: (context, state) {
        return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            // buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
          return state.status == FormzStatus.submissionInProgress
              ? const CircularProgressIndicator(
                  color: AppColors.appSwatchOne,
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.appPrimary,
                        AppColors.appTertiary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    key: const Key('SignUpPage_continue_raisedButton'),
                    onPressed: state.status == FormzStatus.valid &&
                            (state.password.value ==
                                state.confirmPassword.value)
                        ? () {
                            context
                                .read<ChangePasswordBloc>()
                                .add(const ChangePasswordSubmit());
                          }
                        : () {
                            _triggerFieldValidation(
                              state,
                              context,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      fixedSize: const Size(450, 50),
                    ),
                    child: const Text(
                      AppConstants.submit,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
        });
      },
    );
  }
}
