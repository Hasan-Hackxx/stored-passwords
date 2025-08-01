import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/errorDailog.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/auth/auth_exceptions.dart';
import 'package:my_passwords/auth/auth_service.dart';

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
            'please enter your email to send reset password linl to your email',
            style: TextStyle(fontSize: 20),
          ),

          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: 'your emai...'),
          ),

          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                await AuthService.firebase().provider.sendResetpassword(
                  toEmail: email,
                );
              } on InvalidEmailException {
                await showerrorDailog(context, 'invalid email');
              } on UserNoteFoundException {
                await showerrorDailog(context, 'user not found');
              }
            },
            child: Text('send reset passord', style: TextStyle(fontSize: 15)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginViewRoute, (context) => false);
            },
            child: Text('change my mind', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
