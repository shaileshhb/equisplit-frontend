import 'package:equisplit_frontend/models/auth/register_request.dart';
import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/screens/auth/login.dart';
import 'package:equisplit_frontend/services/user/auth.dart';
import 'package:equisplit_frontend/utils/toast.dart';
import 'package:flutter/material.dart';

import '../../utils/user.shared_preference.dart';
import 'components/login_button.dart';
import 'components/login_form_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final usernameController = TextEditingController();
  // final genderController = TextEditingController();
  // final dateOfBirthController = TextEditingController();
  // final contactController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  final genderList = ["Male", "Female", "Other"];

  genderListState() {
    selectedValue = genderList[0];
  }

  String? selectedValue = "";

  onGenderChange(String? gender) {
    setState(() {
      selectedValue = gender;
    });
  }

  void validateUserRegister() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      userRegister();
    }
  }

  void userRegister() async {
    try {
      var userDetails = RegisterRequest(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        // username: usernameController.text,
        // contact: contactController.text,
        // gender: selectedValue,
        // dateOfBirth: dateOfBirthController.text,
      );

      var loginResponse = await AuthenticationService().register(userDetails);

      if (loginResponse != null) {
        // store token in shared preferences.
        _setAuthorizationToken(loginResponse.token);
        _setUserID(loginResponse.userId);

        // navigate to dashboard
        if (mounted) {
          _navigateToOnboardingScreen(context);
        }
      }
    } on CustomException catch (err) {
      print(err);
      ToastNoContext().showErrorToast(err.error);
    }
  }

  void _setAuthorizationToken(String token) async {
    await UserSharedPreference.setAuthorizationToken(token);
  }

  void _setUserID(String userID) async {
    await UserSharedPreference.setUserID(userID);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void _navigateToOnboardingScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void initState() {
    super.initState();
    // genderListState();
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
                children: <Widget>[
                  const SizedBox(height: 50),

                  // // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 60,
                  // ),

                  const SizedBox(height: 20),

                  // welcome message
                  Text(
                    "Welcome! Start tracking your spending!!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // register form
                  LoginFormField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                    validator: (name) {
                      if (name!.isEmpty ||
                          !RegExp(r'[a-z A-Z]+$').hasMatch(name)) {
                        return "Invalid name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

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

                  const SizedBox(height: 15),

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

                  const SizedBox(height: 15),

                  // login button
                  LoginButton(
                    onTap: validateUserRegister,
                    buttonLabel: "Register",
                  ),

                  const SizedBox(height: 30),

                  // redirect to register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color.fromRGBO(97, 97, 97, 1),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _navigateToLogin(context),
                        child: const Text(
                          "Login",
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
