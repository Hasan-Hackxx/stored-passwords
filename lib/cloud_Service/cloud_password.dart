import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_passwords/cloud_Service/cloud_firestore_constents.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudPassword {
  final String doucmentId;
  final String ownerUserId;
  final String text;

  const CloudPassword({
    required this.doucmentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudPassword.fromsnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) : doucmentId = snapshot.id,
      ownerUserId = snapshot.data()[textFieldOwnerId],
      text = snapshot.data()[textpassword] as String;
}
