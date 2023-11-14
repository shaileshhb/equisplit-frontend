import 'package:equisplit_frontend/screens/wrapper.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equisplit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: GlobalColors.seedColor,
          // seedColor: Colors.deepPurple,
          background: GlobalColors.backgroundColor,
        ),
        useMaterial3: true,
      ),
      home: Wrapper(),
    );
  }
}
