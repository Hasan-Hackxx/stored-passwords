import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/logoutDailog.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/firebase_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords page'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamed(createPassordView);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              final shouldlogout = await showlogoutDailog(context);
              if (shouldlogout) {
                await FirebaseAuth.instance.signOut();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginViewRoute, (context) => false);
              }
            },
            icon: Icon(Icons.logout, size: 30),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print('your are verifiaid');
              } else {
                // return const Verifyemailview();
              }
              return const Text('done');
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
