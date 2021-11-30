import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Validation {
  static Future<String> validateSignup(
      email, password, cPassword, name, number) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.length == 1 ? true : false;
      });
      if (user) {
        return "User already exists";
      }
    } else {
      return "Email is Invalid";
    }

    if (name == "") {
      return "Name is required";
    }

    if (number.toString().length != 10) {
      return "Phone Number is Invalid";
    }

    if (password.length < 6 || cPassword.length < 6) {
      return "Password should contain minimum 6 digits";
    }

    if (password != cPassword) {
      return "Passwords do not match";
    }

    return "";
  }

  static Future<String> validateLogin(email, password) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.length == 1 ? true : false;
      });
      if (!user) {
        return "User doesn't exist";
      }
    } else {
      return "Email is Invalid";
    }

    if (password.isEmpty) {
      return "Password is required";
    }

    return "";
  }

  static List<int> toTime(TimeOfDay time) {
    return [time.hour, time.minute];
  }

  static int getMinutes(List<int> time) {
    return (time[0] * 60) + time[1];
  }

  static int getMinutesTimeOfDay(TimeOfDay time) {
    List<int> times = toTime(time);
    return getMinutes(times);
  }

  static String validateRegisterVenue(
    name,
    description,
    contact,
    work_email,
    location,
    price,
    startTime,
    endTime,
    venues,
  ) {
    if (name == "") return "Name is required!";
    if (description == "") return "Description is required!";
    if (contact.toString().length != 10) {
      return "Phone Number is Invalid";
    }
    if (work_email != "") {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(work_email);
      if (!emailValid) return "Invalid email";
    }
    if (location == "") return "Location is required";
    if (price == "") return "Price is required";
    if (startTime == null) return "Start Time is required";
    if (endTime == null) return "End Time is required";
    if (getMinutesTimeOfDay(startTime) > getMinutesTimeOfDay(endTime))
      return "Invalid Time Slot";

    if ((getMinutesTimeOfDay(endTime) - getMinutesTimeOfDay(startTime) < 60))
      return "Duration should be more than 1 hour";

    if (venues.length == 0) return "Upload atleast 1 image";

    return "";
  }
}
