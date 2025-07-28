import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verifyemailview extends StatefulWidget {
  const Verifyemailview({super.key});

  @override
  State<Verifyemailview> createState() => _VerifyemailviewState();
}

class _VerifyemailviewState extends State<Verifyemailview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text(
            'click buttoun below to send Verification to your email...',
            style: TextStyle(fontSize: 20),
          ),

          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              await user?.sendEmailVerification();
            },
            child: const Text(
              'send email verification...',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login/');
            },
            child: const Text('restart'),
          ),
        ],
      ),
    );
  }
}
