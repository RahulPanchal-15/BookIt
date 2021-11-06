import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ProfileTile extends StatelessWidget {
  final IconData? icon;
  final String? text;
  const ProfileTile({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 18,
      ),
      title: Align(
        alignment: Alignment(-1.1, 0),
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: "SourceSansPro",
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
