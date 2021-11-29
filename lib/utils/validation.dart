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
}
