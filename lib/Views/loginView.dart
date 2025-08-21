import 'package:flutter/material.dart';

import 'package:my_passwords/Dailogs/errorDailog.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/auth/Authgoogle.dart';
import 'package:my_passwords/auth/auth_exceptions.dart';
import 'package:my_passwords/auth/auth_service.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Login Page:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.pinkAccent,
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.pinkAccent,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.pinkAccent,
                      size: 25,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        resetpasswordViewRoute,
                        (context) => false,
                      );
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(fontSize: 20, color: Colors.pinkAccent),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pinkAccent, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 150,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final email = _email.text;
                      final password = _password.text;
                      await AuthService.firebase().provider.signin(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentuser;
                      if (user?.isemailVerifaied ?? false) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          passwordsViewRoute,
                          (context) => false,
                        );
                      } else {
                        Navigator.of(context).pushNamed(verifyViewRoute);
                      }
                    } on UserNoteFoundException {
                      await showerrorDailog(context, 'Invalid credential');
                    } on WrongPasswordException {
                      await showerrorDailog(context, 'Invalid credential');
                    } on InvalidEmailException {
                      await showerrorDailog(context, 'Invalid email');
                    } on GenericException {
                      await showerrorDailog(context, 'Authentication error');
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),
                IconButton(
                  onPressed: () async {
                    await Authgoogle().signinwithgoogle();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      passwordsViewRoute,
                      (context) => false,
                    );
                  },
                  icon: Image.asset("images/icons8-google-logo-48.png"),
                ),
                SizedBox(height: 40),
                const Text(
                  'Dont have an account ?',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerViewRoute,
                      (context) => false,
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, color: Colors.amberAccent),
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
