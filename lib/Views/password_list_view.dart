import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/delete_password_dailog.dart';
import 'package:my_passwords/cloud_Service/cloud_password.dart';

typedef Callpasswordfunc = void Function(CloudPassword password);

class PasswordListView extends StatelessWidget {
  final Iterable<CloudPassword> passwords;
  final Callpasswordfunc onDelatepass;
  final Callpasswordfunc ontap;

  const PasswordListView({
    super.key,
    required this.passwords,
    required this.onDelatepass,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passwords.length,
      itemBuilder: (context, index) {
        final password = passwords.elementAt(index);
        return ListTile(
          title: Text(
            password.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            ontap(password);
          },
          trailing: IconButton(
            onPressed: () async {
              final delete = await deletepassword(context);
              if (delete) {
                onDelatepass(password);
              }
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
