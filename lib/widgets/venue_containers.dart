import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../constants.dart';

class VenueContainer extends StatelessWidget {
  final String? text;
  const VenueContainer({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: kBoxDecoration,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 10.0,
          ),
          Text(
            text!,
            style: TextStyle(
              color: Colors.purple,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
