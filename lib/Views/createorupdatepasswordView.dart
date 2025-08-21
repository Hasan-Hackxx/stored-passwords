import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_passwords/Routes.dart';
import 'package:my_passwords/Views/Ui_create_password.dart';
import 'package:my_passwords/auth/auth_service.dart';
import 'package:my_passwords/cloud_Service/cloud_firestore_service.dart';
import 'package:my_passwords/cloud_Service/cloud_password.dart';
import 'package:my_passwords/getArgument.dart';

class Createorupdatepasswordview extends StatefulWidget {
  const Createorupdatepasswordview({super.key});

  @override
  State<Createorupdatepasswordview> createState() =>
      _CreateorupdatepasswordviewState();
}

class _CreateorupdatepasswordviewState
    extends State<Createorupdatepasswordview> {
  CloudPassword? _password;
  String? selectedType;

  late final CloudFirestoreService _passwordservice;
  late final TextEditingController _controller;
  late final TextEditingController _type;

  final items = <Widget>[
    Icon(Icons.save, size: 30, color: const Color.fromARGB(255, 253, 49, 117)),
  ];
  @override
  void initState() {
    _passwordservice = CloudFirestoreService();
    _controller = TextEditingController();
    _type = TextEditingController();
    super.initState();
  }

  void _textcontollerlistener() async {
    final password = _password;
    if (password == null) {
      return null;
    }

    final text = _controller.text;
    final typepass = _type.text;
    await _passwordservice.updatepassword(
      doucmentId: password.doucmentId,
      text: text,
      type: typepass,
    );
  }

  void _deletepasswordifTextempty() async {
    final password = _password;
    if (_controller.text.isEmpty && password != null) {
      await _passwordservice.deletePassword(doucmentId: password.doucmentId);
    }
  }

  void _savepasswordiftextnotempty() async {
    final password = _password;
    final text = _controller.text;
    final typepass = _type.text;
    if (password != null && text.isNotEmpty) {
      await _passwordservice.updatepassword(
        doucmentId: password.doucmentId,
        text: text,
        type: typepass,
      );
    }
  }

  void _setupTextEditingcontollerlistner() {
    _controller.removeListener(_textcontollerlistener);
    _controller.addListener(_textcontollerlistener);
  }

  @override
  void dispose() {
    _savepasswordiftextnotempty();
    _deletepasswordifTextempty();
    _controller.dispose();
    _type.dispose();
    super.dispose();
  }

  Future<CloudPassword> createorgetexistpassword(BuildContext context) async {
    final widgetpassword = context.getArgument<CloudPassword>();

    if (widgetpassword != null) {
      _password = widgetpassword;
      _controller.text = widgetpassword.text;
      return widgetpassword;
    }

    final existingpassord = _password;
    if (existingpassord != null) {
      return existingpassord;
    }

    final currentUser = AuthService.firebase().currentuser!;
    final currentuser = currentUser.id;

    final newPassowrd = await _passwordservice.savePassword(
      ownerUserId: currentuser,
    );
    _password = newPassowrd;
    return newPassowrd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'New Password:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 252, 0),
      ),
      body: FutureBuilder(
        future: createorgetexistpassword(context),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              _setupTextEditingcontollerlistner();
              return UiCreatePassword(controller: _controller, ontype: _type);

            default:
              return CircularProgressIndicator();
          }
        },
      ),

      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        backgroundColor: Colors.black,
        color: const Color.fromARGB(255, 235, 252, 0),
        buttonBackgroundColor: const Color.fromARGB(255, 12, 12, 12),

        height: 60,
        onTap: (value) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(passwordsViewRoute, (context) => false);
        },
      ),
    );
  }
}
