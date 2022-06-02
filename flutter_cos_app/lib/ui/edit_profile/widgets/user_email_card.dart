import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';

class UserEmailCard extends StatelessWidget {
  const UserEmailCard({
    required this.email,
    Key? key,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Email: $email',
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16, color: AppColors.appSwatchTwo),
            ),
          ),
        ),
      ),
    );
  }
}
