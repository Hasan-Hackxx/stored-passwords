import 'package:flutter/material.dart';
import 'package:my_passwords/Dailogs/delete_password_dailog.dart';

import 'package:my_passwords/cloud_Service/cloud_password.dart';

typedef Callpasswordfunc = void Function(CloudPassword password);

class PasswordListView extends StatelessWidget {
  final Iterable<CloudPassword> passwords;
  final Callpasswordfunc onDelatepass;
  final Callpasswordfunc ontap;
  //final CallbackShortcuts tyeppass;

  const PasswordListView({
    super.key,
    required this.passwords,
    required this.onDelatepass,
    required this.ontap,
    //required this.tyeppass,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passwords.length,
      itemBuilder: (context, index) {
        final password = passwords.elementAt(index);

        return ListTile(
          title: Text(
            ' Password Type: ${password.type} \n Password : ${password.text}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),

            maxLines: 5,
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
            icon: Icon(Icons.delete, color: Colors.black87),
          ),
        );
      },
    );
  }
}
