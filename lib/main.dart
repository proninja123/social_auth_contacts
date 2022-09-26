import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialautologin/firebase_options.dart';
import 'package:socialautologin/screens/social_login_screen.dart';
import 'package:socialautologin/utils/colors.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialAuth',
      theme: ThemeData(
        backgroundColor: whiteColor,
      ),
      home: const SocialLoginScreen(),
    );
  }
}

