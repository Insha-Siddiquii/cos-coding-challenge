import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/change_password/widgets/user_password.dart';

import 'change_pswd_button.dart';
import 'confirm_password.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
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
            child: PasswordInput(
              passwdFocusNode: _emailFocusNode,
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
              child: ConfirmPasswordInput(pswdColor: _pswdColor),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const ConfirmPasswordButton()
        ],
      ),
    );
  }
}
