import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/Views/VerifyEmailView.dart';
import 'package:my_passwords/Views/loginView.dart';
import 'package:my_passwords/Views/notesVeiw.dart';
import 'package:my_passwords/Views/registerView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginViewRoute: (context) => Loginview(),
        registerViewRoute: (context) => Registerview(),
        verifyViewRoute: (context) => Verifyemailview(),
        noteViewRoute: (context) => HomePage(),
      },
    );
  }
}
