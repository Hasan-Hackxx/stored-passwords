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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Register Page:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.pinkAccent,
                  ),
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.pinkAccent,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(height: 23),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Passowrd',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.pinkAccent,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pinkAccent, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 130,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final email = _email.text;
                      final password = _password.text;
                      await AuthService.firebase().provider.createuser(
                        email: email,
                        password: password,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyViewRoute,
                        (context) => false,
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
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 100),
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
                      'Already register? Login!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
