import 'package:assignment_practice/widgets/error_msg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import 'dart:io';

import '../constants.dart';
import '../utils/controller_fields.dart';
import '../utils/images_builder.dart';
import '../utils/textfield_builder.dart';
import '../utils/pick_image.dart';
import '../utils/select_time.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../utils/validation.dart';

OwnerFields fields = OwnerFields();
final data = fields.data;
final controllers = fields.generateControllers();
final FocusNode _focusNode = FocusNode();
var venueTypes = ['Turf', 'Studio', 'Banquet'];
String? category = "Turf";

class OwnerRegister extends StatefulWidget {
  final void Function()? goToHome;
  OwnerRegister({Key? key, this.goToHome});
  @override
  _OwnerRegisterState createState() => _OwnerRegisterState();
}

class _OwnerRegisterState extends State<OwnerRegister> {
  List<File?> venueImages = [];
  List<String?> venueUrls = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  // final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance!.currentUser();
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  CollectionReference venues = FirebaseFirestore.instance.collection('venues');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String error = "";

  Future<void> addVenue(String id) {
    // Call the user's CollectionReference to add a new user
    print(id);
    print(data[0]);
    print(data[1]);

    return venues
        .doc(id)
        .set({
          'category': category,
          'name': controllers[0].text.toUpperCase(), // NMC Turf
          'description': controllers[1].text,
          'contact': controllers[2].text,
          'work_email': controllers[3].text, // Stokes and Sons
          'location': controllers[4].text,
          'price': controllers[5].text,
          'startTime':
              startTime!.hour.toString() + ":" + startTime!.hour.toString(),
          'endTime': endTime!.hour.toString() + ":" + endTime!.hour.toString(),
          'venues': venueUrls,
          'createdOn': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Venue Added"))
        .catchError((error) => print("Failed to add venue: $error"));
  }

  Future<void> updateIsOwner(String id) {
    // Call the user's CollectionReference to add a new user
    print(id);
    print(data[0]);
    print(data[1]);

    return users
        .doc(id)
        .update({'isOwner': true})
        .then((value) => print("Owner Status Updated"))
        .catchError((error) => print("Failed to update owner status: $error"));
  }

  @override
  Widget build(BuildContext context) {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    return user == null
        ? Center(
            child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.purple),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text("Please Login First"),
          ))
        : Scaffold(
            body: Container(
              color: Colors.purple,
              child: Center(
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05,
                        horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "Register Your Venue Now!",
                            style:
                                TextStyle(color: Colors.purple, fontSize: 20),
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(children: [
                                  DropdownButton(
                                    // Initial Value

                                    value: category,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: venueTypes.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNode);
                                      setState(() {
                                        category = newValue!;
                                      });
                                    },
                                  ),
                                  ...getTextFields(data, controllers),
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 24,
                                child: ElevatedButton(
                                  style: kButtonStyle.copyWith(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                        EdgeInsets.symmetric(horizontal: 10.0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black54),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setModalState) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            child: Text(
                                                              "Reset",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .purple,
                                                                  fontSize: 18),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 15),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Upload Photo(s)",
                                                              ),
                                                              IconButton(
                                                                onPressed: () =>
                                                                    {
                                                                  pickImage(
                                                                      ImageSource
                                                                          .gallery,
                                                                      (image) {
                                                                    setModalState(
                                                                        () {
                                                                      venueImages
                                                                          .add(
                                                                              image);
                                                                    });
                                                                  })
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .add_a_photo,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  venueImages.isNotEmpty
                                                      ? Expanded(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: getImages(
                                                                venueImages),
                                                          ),
                                                        )
                                                      : Container(),

                                                  //Availability and Time
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 15.0,
                                                            bottom: 10.0),
                                                        child: Text(
                                                          'Availability: ',
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 15.0),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        //Availability
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .schedule),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    selectTime(
                                                                        context,
                                                                        (time) {
                                                                      setModalState(
                                                                          () {
                                                                        startTime =
                                                                            time;
                                                                      });
                                                                    }, startTime);
                                                                  },
                                                                  child: Text(
                                                                    startTime !=
                                                                            null
                                                                        ? "${startTime!.hour.toString()} : ${startTime!.minute.toString()}"
                                                                        : "Start Time",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .purple),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text("To"),
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .schedule_outlined),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    selectTime(
                                                                        context,
                                                                        (time) {
                                                                      setModalState(
                                                                          () {
                                                                        endTime =
                                                                            time;
                                                                      });
                                                                    }, endTime);
                                                                  },
                                                                  child: Text(
                                                                    endTime !=
                                                                            null
                                                                        ? "${endTime!.hour.toString()} : ${endTime!.minute.toString()}"
                                                                        : "End Time",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .purple),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    style:
                                                        kButtonStyle.copyWith(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 80),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Show More ...",
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              error != ""
                                  ? Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ErrorMsg(msg: error),
                                      ),
                                    )
                                  : Container(),
                              //Register Button
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                  child: ElevatedButton(
                                    style: kButtonStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.purple),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(horizontal: 50),
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Provider.of<MyAuth>(context, listen: false)
                                      //     .setIsDone(true);
                                      // Navigator.pop(context);

                                      String valid =
                                          Validation.validateRegisterVenue(
                                              controllers[0].text,
                                              controllers[1].text,
                                              controllers[2].text,
                                              controllers[3].text,
                                              controllers[4].text,
                                              controllers[5].text,
                                              startTime,
                                              endTime,
                                              venueImages);

                                      if (valid == "") {
                                        for (var img in venueImages) {
                                          final ref = FirebaseStorage.instance
                                              .ref()
                                              .child('venue_images/${user.uid}')
                                              .child(
                                                  '${Path.basename(img!.path)}');
                                          await ref.putFile(img);
                                          print('Step1');
                                          final url =
                                              await ref.getDownloadURL();
                                          venueUrls.add(url);
                                        }
                                        print(venueUrls);
                                        await addVenue(user.uid);
                                        await updateIsOwner(user.uid);
                                        Navigator.pop(context);
                                        widget.goToHome!();
                                      } else {
                                        setState(() {
                                          error = valid;
                                        });
                                      }
                                    },
                                    child: Text("Register"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
          );
  }
}
