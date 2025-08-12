import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/generic_dailog.dart';

Future<String> showtypepassword(BuildContext context) {
  return showgenericDailog(
    context: context,
    title: 'Type Password:',
    content: 'Choose a type of password do you want to generate',
    optionbuilder: () => {'Facebook': 'Facebook', 'Instagram': 'Instagram'},
  ).then((value) => value ?? false);
}
