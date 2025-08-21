import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:my_passwords/Dailogs/logoutDailog.dart';

import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/Views/password_list_view.dart';
import 'package:my_passwords/auth/Authgoogle.dart';
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
      backgroundColor: const Color.fromARGB(255, 253, 39, 110),
      appBar: AppBar(
        title: const Text(
          'Passwords page:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(createPassordView, (context) => false);
            },
            icon: Icon(Icons.add, color: Colors.red, size: 40),
          ),
          IconButton(
            onPressed: () async {
              final shouldlogout = await showlogoutDailog(context);
              if (shouldlogout) {
                await FirebaseAuth.instance.signOut();
                await Authgoogle().signoutfromgoogle();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginViewRoute, (context) => false);
              }
            },
            icon: Icon(Icons.logout, size: 40, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
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
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.share,
        backgroundColor: Colors.black,
        foregroundColor: const Color.fromARGB(255, 255, 0, 0),
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child: Icon(Icons.delete, size: 20, color: Colors.blueAccent),
            label: 'Delete All passwords',
            labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            backgroundColor: Colors.black,
            onTap: () async {
              await _service.deleteAllpasswords(ownerUserId: userEmail);
            },
          ),
        ],
      ),
    );
  }
}
