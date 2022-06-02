import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/change_password/bloc/changepaswd_bloc.dart';
import 'package:flutter_cos_app/ui/change_password/model/password.dart';

class ConfirmPasswordInput extends StatefulWidget {
  const ConfirmPasswordInput({
    Key? key,
    required Color pswdColor,
  })  : _pswdColor = pswdColor,
        super(key: key);

  final Color _pswdColor;

  @override
  State<ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<ConfirmPasswordInput> {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.text,
          cursorWidth: 1,
          style: const TextStyle(
            color: AppColors.appFocusField,
            fontSize: 13,
          ),
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(ChangePasswordConfirmChanged(password)),
          obscureText: _obscured ? true : false,
          cursorColor: AppColors.appTertiary,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(
                  _obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 20,
                  color: AppColors.appTertiary,
                ),
              ),
            ),
            errorText: !(state.confirmPassword.pure)
                ? state.confirmPassword.error == PasswordValidationError.empty
                    ? AppConstants.confirmPasswordRequired
                    : state.confirmPassword.value != state.password.value
                        ? AppConstants.passwordNotMatch
                        : null
                : null,
            focusColor: AppColors.appTertiary,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appTertiary,
              ),
            ),
            labelText: AppConstants.confirmPswd,
            labelStyle: TextStyle(
              color: widget._pswdColor,
              fontSize: 13,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appFocusField,
              ),
            ),
          ),
        );
      },
    );
  }
}
