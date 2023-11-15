import 'package:equisplit_frontend/models/auth/login_request.dart';
import 'package:equisplit_frontend/screens/auth/components/login_button.dart';
import 'package:equisplit_frontend/screens/auth/components/login_form_field.dart';
import 'package:equisplit_frontend/screens/auth/register.dart';
import 'package:equisplit_frontend/screens/home/dashboard.dart';
import 'package:equisplit_frontend/services/auth/auth.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controllers for formfield
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  void validateUserLogin() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      userLogin();
    }
  }

  void userLogin() async {
    try {
      var loginRequest = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

      var loginResponse = await AuthenticationService().userLogin(loginRequest);

      if (loginResponse != null) {
        // store token in shared preferences.
        _setAuthorizationToken(loginResponse.token);
        _setUserID(loginResponse.userId);

        // navigate to dashboard
        print(mounted);
        if (mounted) {
          _navigateToDashboard(context);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void _setAuthorizationToken(String token) async {
    await UserSharedPreference.setAuthorizationToken(token);
  }

  void _setUserID(int userID) async {
    await UserSharedPreference.setUserID(userID);
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),

                  // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  // ),

                  const SizedBox(height: 50),

                  // welcome message
                  Text(
                    "Welcome back! you've been missed!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // email, password
                  LoginFormField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    validator: (email) {
                      if (email!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  LoginFormField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return "Invalid password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // login button
                  LoginButton(
                    onTap: validateUserLogin,
                    buttonLabel: "Login",
                  ),

                  const SizedBox(height: 20),

                  // redirect to register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color.fromRGBO(97, 97, 97, 1),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _navigateToSignup(context),
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
