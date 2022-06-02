import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/login/bloc/login_bloc.dart';

import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  _triggerFieldValidation(
    LoginState state,
    BuildContext context,
  ) {
    context.read<LoginBloc>().add(LoginPasswordChanged(state.password.value));
    context.read<LoginBloc>().add(LoginUseremailChanged(state.useremail.value));

    if (state.password.invalid || state.useremail.invalid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.loginInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure &&
            state.errorMsg.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMsg),
          ));
        }
      },
      builder: (context, state) {
        return BlocBuilder<LoginBloc, LoginState>(
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
                        key: const Key('loginForm_continue_raisedButton'),
                        onPressed: state.status == FormzStatus.valid
                            ? () {
                                context
                                    .read<LoginBloc>()
                                    .add(const LoginWithCredentials());
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
                          AppConstants.login,
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
