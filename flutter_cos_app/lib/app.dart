import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/ui/app_authentication/bloc/authentication_bloc.dart';
import 'package:flutter_cos_app/ui/change_password/view/change_paswd_page.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:flutter_cos_app/ui/edit_profile/view/edit_profile_page.dart';
import 'package:flutter_cos_app/ui/login/view/login_page.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/view/vehicle_detail.dart';

import 'ui/vehicle_inspection_overview/view/vehicle_inspection.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final RemoteAuthRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      routes: {
        VehicleInspectionPage.routeName: (context) =>
            const VehicleInspectionPage(),
        VehicleInspectionDetail.routeName: (context) =>
            const VehicleInspectionDetail(),
        ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
        EditProfilePage.routeName: (context) => const EditProfilePage(),
      },
      home: UserEditModel().getUserEmail().isEmpty
          ? const LoginPage()
          : const VehicleInspectionPage(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  VehicleInspectionPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
