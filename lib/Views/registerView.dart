import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/errorDailog.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/auth/auth_exceptions.dart';
import 'package:my_passwords/auth/auth_service.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
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
      appBar: AppBar(
        title: Text('Register Page'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Sign up..',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'email.....',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                hintText: 'passowrd.....',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
                  await AuthService.firebase().provider.createuser(
                    email: email,
                    password: password,
                  );
                } on InvalidEmailException {
                  await showerrorDailog(context, 'invalid email');
                } on WeakPasswordException {
                  await showerrorDailog(context, 'weak password');
                } on EmailAlreadyInUseException {
                  await showerrorDailog(context, 'email already in use');
                } on GenericException {
                  await showerrorDailog(context, 'authintcation error');
                }
              },
              child: Text('Register', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginViewRoute, (context) => false);
              },
              child: Text(
                'already register?login!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
