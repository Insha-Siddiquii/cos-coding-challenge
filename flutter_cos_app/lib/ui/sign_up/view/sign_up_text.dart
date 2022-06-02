import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/sign_up/view/sign_up_page.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(SignUpPage.route());
        },
        child: RichText(
          text: const TextSpan(
            text: AppConstants.newUser,
            style: TextStyle(color: AppColors.appSwatchTwo, fontSize: 18),
            children: [
              TextSpan(
                text: AppConstants.signUp,
                style: TextStyle(
                  color: AppColors.appPrimary,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
