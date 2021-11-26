import 'package:flutter/cupertino.dart';

class OwnerFields {
  List<String> data = [
    "Venue Name",
    'Description',
    "Contact",
    'Work Email(if any)',
    "Category",
    "Location",
    "Price",
  ];

  List<TextEditingController> generateControllers() {
    List<TextEditingController> controllers = [];
    for (int i = 0; i < data.length; i++) {
      controllers.add(TextEditingController());
    }
    return controllers;
  }
}
