import 'package:equisplit_frontend/screens/splash/splash_screen.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final bool isLoggedIn = UserSharedPreference.getAuthorizationToken() != null;

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
