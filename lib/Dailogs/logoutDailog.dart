import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/generic_dailog.dart';

Future<bool> showlogoutDailog(BuildContext context) {
  return showgenericDailog(
    context: context,
    title: 'logout',
    content: 'Are you sure you want to logout..! ',
    optionbuilder: () => {'yes': true, 'cancel': false},
  ).then((value) => value ?? false);
}
