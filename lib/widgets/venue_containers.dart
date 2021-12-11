import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../constants.dart';

class VenueContainer extends StatelessWidget {
  final String? text;
  final bool? isSelected;
  final void Function()? onPressed;
  const VenueContainer({
    Key? key,
    this.text,
    this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        decoration: isSelected! ? kBoxDecorationSelected : kBoxDecoration,
        margin: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: isSelected! ? Colors.white : Colors.purple,
              size: 10.0,
            ),
            Text(
              text!,
              style: TextStyle(
                color: isSelected! ? Colors.white : Colors.purple,
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
