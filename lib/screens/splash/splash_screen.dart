import 'package:equisplit_frontend/screens/auth/login.dart';
import 'package:equisplit_frontend/screens/home/dashboard.dart';
import 'package:equisplit_frontend/services/user/auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    try {
      var response = await AuthenticationService().getUser();
      if (response != null) {
        _navigateToDashboard();
        return;
      }
      _navigateToLogin();
    } catch (err) {
      print(err);
      _navigateToLogin();
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Dashboard(selectedIndex: 0)));
  }

  _navigateToLogin() async {
    // await Future.delayed(const Duration(milliseconds: 1500), () {
    // });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EquiSplit",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   "Simplify Shared Expenses",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
