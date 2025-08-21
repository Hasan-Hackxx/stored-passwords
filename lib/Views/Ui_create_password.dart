import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UiCreatePassword extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController ontype;
  const UiCreatePassword({
    super.key,
    required this.controller,
    required this.ontype,
  });

  @override
  State<UiCreatePassword> createState() => _UiCreatePasswordState();
}

class _UiCreatePasswordState extends State<UiCreatePassword> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'please choose your passwod type from Icons below:',
            style: TextStyle(
              fontSize: 20,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = "Facebook";
                      widget.ontype.text = 'Facebook';
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(FontAwesomeIcons.facebook),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = "Instagram";
                      widget.ontype.text = "Instagram";
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.pink,
                        child: Icon(FontAwesomeIcons.instagram),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Instagram',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = "Twitter";
                      widget.ontype.text = "Twitter";
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.lightBlue,
                        child: Icon(FontAwesomeIcons.twitter),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Twitter',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (selectedType != null) ...[
            TextField(
              controller: widget.ontype,
              style: TextStyle(color: Colors.white),
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'your passwod type',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: widget.controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your password',

                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
