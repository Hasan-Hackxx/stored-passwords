import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/generic_dailog.dart';

Future<bool> deletepassword(BuildContext context) {
  return showgenericDailog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this password',
    optionbuilder: () => {'yes': true, 'cancel': false},
  ).then((value) => value ?? false);
}
