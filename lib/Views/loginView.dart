import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/errorDailog.dart';
import 'package:my_passwords/Routes.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page:'), backgroundColor: Colors.blue),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Login..',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'email.....',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                hintText: 'password.....',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),

            TextButton(
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  Navigator.of(context).pushNamedAndRemoveUntil(
                    passwordsViewRoute,
                    (context) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-credential') {
                    await showerrorDailog(context, 'invalid credential');
                  } else if (e.code == 'invalid-email') {
                    await showerrorDailog(context, 'invalid email');
                  } else {
                    await showerrorDailog(context, 'authentication error');
                  }
                }
              },
              child: Text('login', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerViewRoute,
                  (context) => false,
                );
              },
              child: Text('not sing up yet!.', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  resetpasswordViewRoute,
                  (context) => false,
                );
              },
              child: const Text(
                'Forget password?',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
