import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/sign_up/bloc/signup_bloc.dart';
import 'package:flutter_cos_app/ui/sign_up/model/useremail.dart';

class UserEmailInput extends StatelessWidget {
  const UserEmailInput({
    Key? key,
    required FocusNode emailFocusNode,
    required Color emailColor,
  })  : _emailFocusNode = emailFocusNode,
        _emailColor = emailColor,
        super(key: key);

  final FocusNode _emailFocusNode;
  final Color _emailColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.useremail != current.useremail,
      builder: (context, state) {
        return TextField(
          key: const Key('SignUpPage_usernameInput_textField'),
          cursorWidth: 1,
          style: const TextStyle(
            color: AppColors.appFocusField,
            fontSize: 13,
          ),
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocusNode,
          cursorColor: AppColors.appTertiary,
          decoration: InputDecoration(
            focusColor: AppColors.appTertiary,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appTertiary,
              ),
            ),
            labelText: AppConstants.emailId,
            labelStyle: TextStyle(
              color: _emailColor,
              fontSize: 13,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appFocusField,
              ),
            ),
            errorText: !(state.useremail.pure)
                ? state.useremail.error == UseremailValidationError.empty
                    ? AppConstants.emailRequired
                    : state.useremail.error == UseremailValidationError.inValid
                        ? AppConstants.emailInvalid
                        : null
                : null,
          ),
          onChanged: (useremail) =>
              context.read<SignUpBloc>().add(SignUpUseremailChanged(useremail)),
        );
      },
    );
  }
}
