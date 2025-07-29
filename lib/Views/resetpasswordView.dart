import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:my_passwords/Routes.dart';

class Resetpasswordview extends StatefulWidget {
  const Resetpasswordview({super.key});

  @override
  State<Resetpasswordview> createState() => _ResetpasswordviewState();
}

class _ResetpasswordviewState extends State<Resetpasswordview> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password:'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const Text(
            'please enter your email to send reset password link to your email',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),

          TextField(
            controller: _email,

            decoration: InputDecoration(hintText: 'your email'),
          ),

          TextButton(
            onPressed: () async {
              final email = _email.text;
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
            },
            child: const Text(
              'Send Resetpassword',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginViewRoute, (context) => false);
            },
            child: const Text('change my mind', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
