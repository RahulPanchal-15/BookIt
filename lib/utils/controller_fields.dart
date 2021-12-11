import 'package:flutter/cupertino.dart';

class OwnerFields {
  List<String> data = [
    "Venue Name*",
    'Description*',
    "Contact*",
    'Work Email',
    "Location*",
    "Price* (Example: 2000/hr)",
  ];

  List<TextEditingController> generateControllers() {
    List<TextEditingController> controllers = [];
    for (int i = 0; i < data.length; i++) {
      controllers.add(TextEditingController());
    }
    return controllers;
  }
}
