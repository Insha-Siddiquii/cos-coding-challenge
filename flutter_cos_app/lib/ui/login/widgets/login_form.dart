import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/login/widgets/login_button.dart';
import 'package:flutter_cos_app/ui/login/widgets/user_email.dart';
import 'package:flutter_cos_app/ui/login/widgets/user_password.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FocusNode _emailFocusNode = FocusNode();
  final Color _emailColor = AppColors.appFocusField;
  Color _pswdColor = AppColors.appFocusField;

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
              bottom: 10,
            ),
            child: UserEmailInput(
              emailFocusNode: _emailFocusNode,
              emailColor: _emailColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Focus(
              onFocusChange: (focusChange) {
                setState(
                  () {
                    _pswdColor = focusChange
                        ? AppColors.appPrimary
                        : AppColors.appFocusField;
                  },
                );
              },
              child: UserPasswordInput(pswdColor: _pswdColor),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const LoginButton()
        ],
      ),
    );
  }
}
