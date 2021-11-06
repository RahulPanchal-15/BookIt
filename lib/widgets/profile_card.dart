import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ProfileCard extends StatelessWidget {
  final IconData? icon;
  final String? text;
  const ProfileCard({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.purple, spreadRadius: 1),
        ],
      ),
      // color: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 18.0,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.teal.shade800,
            size: 20,
          ),
          SizedBox(
            width: 34.0,
          ),
          Text(
            //Null Safety for String Text
            text!,
            style: TextStyle(
              color: Colors.teal.shade900,
              fontFamily: 'SourceSansPro',
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
