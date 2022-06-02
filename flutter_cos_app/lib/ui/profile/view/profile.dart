import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/change_password/view/change_paswd_page.dart';
import 'package:flutter_cos_app/ui/edit_profile/view/edit_profile_page.dart';
import 'package:flutter_cos_app/ui/login/bloc/login_bloc.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UserProfile());
  }

  final List<Map<String, dynamic>> _settingsOption = [
    {
      'title': AppConstants.changeProfile,
      'icon': Icons.account_circle,
      'route': EditProfilePage.routeName,
    },
    {
      'title': AppConstants.changePassword,
      'icon': Icons.lock_outline,
      'route': ChangePasswordPage.routeName
    },
    {
      'title': AppConstants.logout,
      'icon': Icons.exit_to_app,
      'route': null,
    },
  ];
  showLogoutDialog(BuildContext context) {
    Widget noButton = TextButton(
      child: const Text(
        AppConstants.no,
        style: TextStyle(color: AppColors.appPrimary),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: const Text(
        AppConstants.yes,
        style: TextStyle(color: AppColors.appPrimary),
      ),
      onPressed: () {
        context.read<LoginBloc>().add(const LogOut());
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        AppConstants.logout,
        style: TextStyle(color: AppColors.appBlack),
      ),
      content: const Text(
        AppConstants.logoutMsg,
        style: TextStyle(color: AppColors.appBlack),
      ),
      actions: [noButton, yesButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                AppColors.appPrimary,
                AppColors.appTertiary,
              ],
            ),
          ),
        ),
        title: const Text(
          AppConstants.userProfile,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        // actions: [
        //   BlocProvider(
        //     create: (context) {
        //       return LoginBloc(
        //         authenticationRepository:
        //             RepositoryProvider.of<AuthenticationRepository>(context),
        //       );
        //     },
        //     child: BlocBuilder<LoginBloc, LoginState>(
        //       // buildWhen: (previous, current) =>
        //       //     previous.password != current.password,
        //       builder: (context, state) {
        //         return IconButton(
        //           icon: const Icon(Icons.exit_to_app),
        //           onPressed: () {
        //             showLogoutDialog(context);
        //           },
        //         );
        //       },
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
        child: ListView.separated(
          itemCount: _settingsOption.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: AppColors.appTertiary,
            indent: 5,
            endIndent: 4,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) {
                return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<RemoteAuthRepository>(context),
                );
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ListTile(
                    leading: Icon(
                      _settingsOption[index]['icon'],
                      size: 30,
                      color: AppColors.appSwatchOne,
                    ),
                    title: Text(
                      _settingsOption[index]['title'],
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.appBlack),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.appPrimary,
                    ),
                    onTap: () {
                      if (_settingsOption[index]['title'] ==
                          AppConstants.logout) {
                        showLogoutDialog(context);
                      } else {
                        Navigator.of(context)
                            .pushNamed(_settingsOption[index]['route']);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
