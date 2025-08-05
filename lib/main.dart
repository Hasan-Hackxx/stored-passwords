import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/Views/VerifyEmailView.dart';
import 'package:my_passwords/Views/createorupdatepasswordView.dart';
import 'package:my_passwords/Views/loginView.dart';
import 'package:my_passwords/Views/passwordsVeiw.dart';
import 'package:my_passwords/Views/registerView.dart';
import 'package:my_passwords/Views/resetpasswordView.dart';
import 'package:my_passwords/auth/auth_service.dart';
import 'package:my_passwords/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().provider.initilaizeup();
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
      home: const Loginview(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginViewRoute: (context) => Loginview(),
        registerViewRoute: (context) => Registerview(),
        verifyViewRoute: (context) => Verifyemailview(),
        passwordsViewRoute: (context) => PasswordView(),
        resetpasswordViewRoute: (context) => Resetpasswordview(),
        createPassordView: (context) => Createorupdatepasswordview(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentuser;
              if (user?.isemailVerifaied ?? false) {
                return const PasswordView();
              } else {
                return const Verifyemailview();
              }

            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
