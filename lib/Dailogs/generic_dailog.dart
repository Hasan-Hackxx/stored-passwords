import 'package:flutter/material.dart';

typedef Genericoptions<T> = Map<String, T> Function();

Future<T?> showgenericDailog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required Genericoptions optionbuilder,
}) {
  final options = optionbuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optiontitle) {
          final T value = options[optiontitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optiontitle),
          );
        }).toList(),
      );
    },
  );
}
