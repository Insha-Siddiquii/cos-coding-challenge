import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/login/bloc/login_bloc.dart';
import 'package:flutter_cos_app/ui/login/widgets/google_login.dart';
import 'package:flutter_cos_app/ui/login/widgets/login_form.dart';
import 'package:flutter_cos_app/ui/sign_up/view/sign_up_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhite,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<RemoteAuthRepository>(context),
          );
        },
        child: const LoginBody(),
      )),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 20,
        top: 12,
        right: 20,
      ),
      children: const [
        Text(
          '${AppConstants.welcome},',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.appBlack,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppConstants.signInContinue,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.appSwatchTwo,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        LoginForm(),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            AppConstants.loginWith,
            style: TextStyle(color: AppColors.appSwatchTwo, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GoogleLogin(),
        SizedBox(
          height: 30,
        ),
        SignUpText()
      ],
    );
  }
}
