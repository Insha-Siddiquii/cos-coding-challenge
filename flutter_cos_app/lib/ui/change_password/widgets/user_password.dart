import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/change_password/bloc/changepaswd_bloc.dart';
import 'package:flutter_cos_app/ui/change_password/model/password.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    required FocusNode passwdFocusNode,
    required Color emailColor,
  })  : _pswdFocusNode = passwdFocusNode,
        _pswdColor = emailColor,
        super(key: key);

  final FocusNode _pswdFocusNode;
  final Color _pswdColor;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      //buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          focusNode: widget._pswdFocusNode,
          keyboardType: TextInputType.text,
          cursorWidth: 1,
          style: const TextStyle(
            color: AppColors.appFocusField,
            fontSize: 13,
          ),
          onChanged: (password) {
            context
                .read<ChangePasswordBloc>()
                .add(ChangePasswordChanged(password));
          },
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
            errorText: !(state.password.pure)
                ? state.password.error == PasswordValidationError.empty
                    ? AppConstants.passwordRequired
                    : state.password.error == PasswordValidationError.inValid
                        ? AppConstants.passwordInvalid
                        : null
                : null,
            focusColor: AppColors.appTertiary,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appTertiary,
              ),
            ),
            labelText: AppConstants.newPswd,
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
