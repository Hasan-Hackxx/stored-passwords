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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Reset password:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'please enter your email to send reset password linl to your email',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.yellowAccent,
                    fontSize: 20,
                  ),
                  suffixIcon: Icon(Icons.email, size: 25, color: Colors.pink),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.pinkAccent, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
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
                child: Text(
                  'send reset passord',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginViewRoute,
                      (context) => false,
                    );
                  },
                  child: Text(
                    'return to login!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
