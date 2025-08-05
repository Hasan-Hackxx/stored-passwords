import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/logoutDailog.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/Views/password_list_view.dart';
import 'package:my_passwords/auth/auth_service.dart';
import 'package:my_passwords/cloud_Service/cloud_firestore_service.dart';
import 'package:my_passwords/cloud_Service/cloud_password.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  late final CloudFirestoreService _service;
  String get userEmail => AuthService.firebase().currentuser!.id;

  @override
  void initState() {
    _service = CloudFirestoreService();
    super.initState();
  }

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
      body: StreamBuilder(
        stream: _service.allpasswords(ownerUserId: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allpasswords = snapshot.data as Iterable<CloudPassword>;
                return PasswordListView(
                  passwords: allpasswords,
                  onDelatepass: (password) async {
                    await _service.deletePassword(
                      doucmentId: password.doucmentId,
                    );
                  },
                  ontap: (password) {
                    Navigator.of(
                      context,
                    ).pushNamed(createPassordView, arguments: password);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
