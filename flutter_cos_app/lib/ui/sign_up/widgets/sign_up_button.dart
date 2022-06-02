import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/sign_up/bloc/signup_bloc.dart';
import 'package:formz/formz.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  _triggerFieldValidation(
    SignUpState state,
    BuildContext context,
  ) {
    context.read<SignUpBloc>().add(SignUpPasswordChanged(state.password.value));
    context
        .read<SignUpBloc>()
        .add(SignUpUseremailChanged(state.useremail.value));

    if (state.password.invalid || state.useremail.invalid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.signUpInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure &&
            state.errorMsg.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => previous.status != current.status,
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
                        onPressed: state.status == FormzStatus.valid
                            ? () {
                                context
                                    .read<SignUpBloc>()
                                    .add(const SignUpWithCredentials());
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
