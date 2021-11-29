import 'package:flutter/material.dart';
import '../constants.dart';

List<TextField> getTextFields(
    List<String> fieldName, List<TextEditingController> controllers) {
  List<TextField> widgetsList = [];

  for (int i = 0; i < fieldName.length; i++) {
    widgetsList.add(
      TextField(
        controller: controllers[i],
        decoration: kInputDecoration.copyWith(
          hintText: fieldName[i],
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }
  return widgetsList;
}
