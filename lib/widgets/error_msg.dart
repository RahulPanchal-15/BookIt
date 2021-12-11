import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String? msg;
  const ErrorMsg({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg!,
      style: TextStyle(color: Colors.red),
    );
  }
}
