import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isemailVerifaied;
  final String id;

  const AuthUser({required this.id, required this.isemailVerifaied});

  factory AuthUser.fromfirebase(User user) =>
      AuthUser(isemailVerifaied: user.emailVerified, id: user.uid);
}
