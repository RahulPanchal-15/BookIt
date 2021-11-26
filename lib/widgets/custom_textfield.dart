import 'package:assignment_practice/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  void Function(String)? onChange;
  CustomTextField({Key? key, this.hintText, this.onChange}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      decoration: kInputDecoration.copyWith(
        hintText: widget.hintText,
      ),
    );
  }
}
