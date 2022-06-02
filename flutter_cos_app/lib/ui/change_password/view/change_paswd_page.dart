import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/change_password/bloc/changepaswd_bloc.dart';
import 'package:flutter_cos_app/ui/change_password/widgets/change_pswd_form.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChangePasswordPage());
  }

  static const routeName = '/changePassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhite,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.appPrimary,
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            return ChangePasswordBloc(
              authenticationRepository:
                  RepositoryProvider.of<RemoteAuthRepository>(context),
            );
          },
          child: ListView(
            padding: const EdgeInsets.only(
              left: 20,
              top: 12,
              right: 20,
            ),
            children: const [
              Text(
                '${AppConstants.hello},',
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
                AppConstants.changePasswordMesg,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.appSwatchTwo,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ChangePasswordBody(),
            ],
          ),
        ),
      ),
    );
  }
}
