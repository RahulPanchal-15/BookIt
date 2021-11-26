import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constants.dart';
import '../fields.dart';
import '../widgets/images_builder.dart';
import '../widgets/textfield_builder.dart';
import '../widgets/pick_image.dart';
import '../widgets/select_time.dart';

OwnerFields fields = OwnerFields();
final data = fields.data;
final controllers = fields.generateControllers();

class OwnerRegister extends StatefulWidget {
  const OwnerRegister({Key? key}) : super(key: key);
  @override
  _OwnerRegisterState createState() => _OwnerRegisterState();
}

class _OwnerRegisterState extends State<OwnerRegister> {
  bool? isOwner = true;
  List<File?> venueImages = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
        child: Center(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                  horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: kButtonStyle,
                      onPressed: () {
                        setState(() {
                          isOwner = !(isOwner!);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Venue owner?"),
                          Icon(Icons.circle,
                              color: isOwner! ? Colors.green : Colors.red,
                              size: 20),
                        ],
                      ),
                    ),
                    isOwner!
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: getTextFields(data, controllers),
                            ),
                          )
                        : Container(),
                    isOwner!
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: kButtonStyle.copyWith(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 40.0)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                          "Reset",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.purple,
                                                              fontSize: 18),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10, bottom: 15),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Upload Photo(s)",
                                                          ),
                                                          IconButton(
                                                            onPressed: () => {
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
                                                              Icons.add_a_photo,
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
                                                    CrossAxisAlignment.start,
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    //Availability
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons.schedule),
                                                            TextButton(
                                                              onPressed: () {
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
                                                              onPressed: () {
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
                                                                endTime != null
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
                                                style: kButtonStyle.copyWith(
                                                  padding: MaterialStateProperty
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
                              child: Text("Show More ..."),
                            ),
                          )
                        : Container(),

                    //Register / Next Button
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                      child: ElevatedButton(
                        style: kButtonStyle.copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black54),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 50),
                          ),
                        ),
                        onPressed: isOwner!
                            ? () {
                                // Provider.of<MyAuth>(context, listen: false)
                                //     .setIsDone(true);
                                // Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OwnerRegister(),
                                  ),
                                );
                                Navigator.pushReplacementNamed(
                                    context, '/main');
                              }
                            : () {
                                Navigator.pushReplacementNamed(
                                    context, '/main');
                              },
                        child: Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
