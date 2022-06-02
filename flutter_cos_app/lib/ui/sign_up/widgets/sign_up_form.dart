import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/sign_up/widgets/sign_up_button.dart';
import 'package:flutter_cos_app/ui/sign_up/widgets/user_email.dart';
import 'package:flutter_cos_app/ui/sign_up/widgets/user_password.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  FocusNode _emailFocusNode = FocusNode();
  final Color _emailColor = AppColors.appFocusField;
  late Color _pswdColor = AppColors.appFocusField;

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
          const SignUpButton()
        ],
      ),
    );
  }
}
