import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/generic_dailog.dart';

Future<void> showerrorDailog(BuildContext context, String text) {
  return showgenericDailog(
    context: context,
    title: 'Error',
    content: text,
    optionbuilder: () => {'ok': null},
  );
}
