import 'package:assignment_practice/constants.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  bool? showPass;
  final String? hintText;
  void Function(String)? onChange;
  CustomPasswordField({Key? key, this.hintText, this.showPass, this.onChange})
      : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      obscureText: !widget.showPass!,
      decoration: kInputDecoration.copyWith(
        hintText: widget.hintText!,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: widget.showPass! ? Colors.blue : Colors.grey,
            size: 20.0,
          ),
          onPressed: () {
            setState(() => widget.showPass = !widget.showPass!);
          },
        ),
      ),
    );
  }
}
