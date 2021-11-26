import 'package:flutter/material.dart';
import 'dart:io';

List<Widget> getImages(List<File?> imagesList) {
  List<Widget> widgetsList = [];

  for (int i = 0; i < imagesList.length; i++) {
    widgetsList.add(Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                imagesList[i]!,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
  return widgetsList;
}
