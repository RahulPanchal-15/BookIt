import 'package:flutter/material.dart';

Future selectTime(
    BuildContext context, Function callBack, TimeOfDay? time) async {
  final TimeOfDay? picked =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (picked != null) {
    callBack(picked);
  }
}
