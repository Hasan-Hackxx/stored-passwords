import 'package:flutter/material.dart';
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
  late final CloudFirestoreService _passwordservice;
  late final TextEditingController _controller;

  @override
  void initState() {
    _passwordservice = CloudFirestoreService();
    _controller = TextEditingController();
    super.initState();
  }

  void _textcontollerlistener() async {
    final password = _password;
    if (password == null) {
      return null;
    }

    final text = _controller.text;
    await _passwordservice.updatepassword(
      doucmentId: password.doucmentId,
      text: text,
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
    if (password != null && text.isNotEmpty) {
      await _passwordservice.updatepassword(
        doucmentId: password.doucmentId,
        text: text,
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
      appBar: AppBar(
        title: const Text('New Password:'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<CloudPassword>(
        future: createorgetexistpassword(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextEditingcontollerlistner();
              SizedBox(height: 10);
              return TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(hintText: 'type your password..'),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
