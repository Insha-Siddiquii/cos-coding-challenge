import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:flutter_cos_app/ui/edit_profile/widgets/user_email_card.dart';
import 'package:flutter_cos_app/ui/edit_profile/widgets/user_photo.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfilePage());
  }

  static const routeName = '/editProfile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserEditModel _profile;

  @override
  void initState() {
    super.initState();
    _profile = UserEditModel(userEmail: '', userPhoto: '');
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
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: _profile.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.appSwatchTwo,
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(30.0),
            children: [
              UserPhoto(photo: ((snapshot.data)! as UserEditModel).userPhoto),
              const SizedBox(height: 20),
              UserEmailCard(
                  email: ((snapshot.data)! as UserEditModel).userEmail),
            ],
          );
        },
      )),
    );
  }
}
