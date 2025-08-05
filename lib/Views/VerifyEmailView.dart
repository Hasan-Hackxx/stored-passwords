import 'package:flutter/material.dart';
import 'package:my_passwords/auth/auth_service.dart';

class Verifyemailview extends StatefulWidget {
  const Verifyemailview({super.key});

  @override
  State<Verifyemailview> createState() => _VerifyemailviewState();
}

class _VerifyemailviewState extends State<Verifyemailview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email:'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text(
              'click buttoun below to send Verification to your email...',
              style: TextStyle(fontSize: 20),
            ),

            TextButton(
              onPressed: () async {
                AuthService.firebase().provider.currentuser;

                await AuthService.firebase().provider.sendEmailVerivication();
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
      ),
    );
  }
}
