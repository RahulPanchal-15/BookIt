import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../screens/signup_login.dart';
import '../utils/select_time.dart';
import '../constants.dart';
import '../utils/select_date.dart';

class VenueDetailPage extends StatefulWidget {
  // final String? name;
  // final String? location;
  // final String? description;
  // final String? price;
  final String? id;
  final void Function()? goToNotifications;
  final void Function()? goToLogin;

  const VenueDetailPage(
      {Key? key, this.id, this.goToNotifications, this.goToLogin})
      : super(key: key);

  @override
  _VenueDetailPageState createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  bool isPressed = false;
  String? search;
  TimeOfDay? rstartTime;
  TimeOfDay? rendTime;
  DateTime? rdate;

  auth.User? user = auth.FirebaseAuth.instance.currentUser;

  final List<String> imagesList = [
    "https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/09/12/Photos/turf-kHJF--621x414@LiveMint.jpg",
  ];

  static const IconData location_pin =
      IconData(58284, fontFamily: 'MaterialIcons');
  static const IconData article_rounded =
      IconData(0xf580, fontFamily: 'MaterialIcons');
  static const IconData monetization_rounded =
      IconData(63695, fontFamily: 'MaterialIcons');
  static const IconData star_outlined =
      IconData(58874, fontFamily: 'MaterialIcons');
  static const IconData calendar_outlined =
      IconData(57634, fontFamily: 'MaterialIcons');
  static const IconData call_outlined =
      IconData(57638, fontFamily: 'MaterialIcons');
  CollectionReference venues = FirebaseFirestore.instance.collection('venues');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  List<int> getHoursMins(String time) {
    return [int.parse(time.split(":")[0]), int.parse(time.split(":")[1])];
  }

  int getSeconds(List<int> time) {
    return (time[0] * 60) + time[1];
  }

  List<int> toTime(TimeOfDay time) {
    return [time.hour, time.minute];
  }

  String formattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date).replaceAll("-", "/");
  }

  Future<void> addRequest(
      String userId, String startTimeS, String endTimeS) async {
    // print(allRequests);

    int vstartTime = getSeconds(getHoursMins(startTimeS));
    int vendTime = getSeconds(getHoursMins(endTimeS));

    int rstart = getSeconds(toTime(rstartTime!));
    int rend = getSeconds(toTime(rendTime!));

    bool slotBookedAlready = false;

    // print(vstartTime);
    // print(vendTime);
    // print(rstart);
    // print(rend);

    if (rstart >= vstartTime && rend <= vendTime) {
      QuerySnapshot allRequests = await requests
          .where('ownerId', isEqualTo: widget.id)
          .where('date', isEqualTo: formattedDate(rdate!))
          .get();

      print(allRequests.size);

      allRequests.docs.forEach((element) {
        int qstart = getSeconds(getHoursMins(element['startTime']));
        int qend = getSeconds(getHoursMins(element['endTime']));
        print(qstart);
        print(qend);

        if (rstart >= qstart && rend <= qend) {
          print("Slot already booked!");
          slotBookedAlready = true;
        }
      });

      if (!slotBookedAlready) {
        return requests
            .add({
              'ownerId': widget.id,
              'userId': userId,
              'date': formattedDate(rdate!),
              'startTime': "${rstartTime!.hour}:${rstartTime!.minute}",
              'endTime': "${rendTime!.hour}:${rendTime!.minute}",
              'status': 2,
            })
            .then((value) => print("Request Added"))
            .catchError((error) => print("Failed to add request: $error"));
      }

      return;
    }

    print("Slot out of range!");
    return;
  }

  var kBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Colors.purple, spreadRadius: 1),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot?>(
          stream: FirebaseFirestore.instance
              .collection('venues')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white])),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  // appBar: ,
                  body: Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: CarouselSlider(
                                items: snapshot.data!['venues']
                                    .map<Widget>((e) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Image.network(e,
                                                  width: 1000,
                                                  height: 200,
                                                  fit: BoxFit.cover)
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true)),
                          ),
                          const Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    snapshot.data!['name'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                  },
                                  child: Icon(
                                    isPressed
                                        ? CupertinoIcons.heart_fill
                                        : Icons.favorite_outline,
                                    color: isPressed
                                        ? Colors.redAccent[700]
                                        : Colors.black,
                                    size: 28.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                )
                              ]),
                          const Divider(),
                          VenueDetailTile(
                              iconName: location_pin,
                              title: snapshot.data!['location']),
                          VenueDetailTile(
                              iconName: article_rounded,
                              title: snapshot.data!['description'] ??
                                  "A wholesame turf for football lovers in the heart of Navi Mumbai."),
                          VenueDetailTile(
                              iconName: monetization_rounded,
                              title: snapshot.data!['price']),
                          VenueDetailTile(
                              iconName: Icons.event_available,
                              title:
                                  "Availability: ${snapshot.data!['startTime']} - ${snapshot.data!['endTime']}"),
                          const Divider(
                            thickness: 0,
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Date:",
                                        style: TextStyle(
                                            color: Colors.purple, fontSize: 16),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range),
                                                  TextButton(
                                                    onPressed: () async {
                                                      var date =
                                                          await selectDate(
                                                              context,
                                                              DateTime.now());
                                                      setState(() {
                                                        rdate = date;
                                                      });
                                                    },
                                                    child: Text(
                                                      rdate != null
                                                          ? "${rdate!.day}/${rdate!.month}/${rdate!.year}"
                                                          : "Choose Booking Date",
                                                      style: TextStyle(
                                                          color: Colors.purple),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Slot:",
                                        style: TextStyle(
                                            color: Colors.purple, fontSize: 16),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.schedule),
                                                  TextButton(
                                                    onPressed: () {
                                                      selectTime(context,
                                                          (time) {
                                                        setState(() {
                                                          rstartTime = time;
                                                        });
                                                      }, rstartTime);
                                                    },
                                                    child: Text(
                                                      rstartTime != null
                                                          ? "${rstartTime!.hour.toString()} : ${rstartTime!.minute.toString()}"
                                                          : "Start",
                                                      style: TextStyle(
                                                          color: Colors.purple),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text("TO"),
                                              Row(
                                                children: [
                                                  Icon(Icons.schedule_outlined),
                                                  TextButton(
                                                    onPressed: () {
                                                      selectTime(context,
                                                          (time) {
                                                        setState(() {
                                                          rendTime = time;
                                                        });
                                                      }, rendTime);
                                                    },
                                                    child: Text(
                                                      rendTime != null
                                                          ? "${rendTime!.hour.toString()} : ${rendTime!.minute.toString()}"
                                                          : "End",
                                                      style: TextStyle(
                                                          color: Colors.purple),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  //if setFlag=1 , then Available
                                  "Book",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onPressed: () async {
                                  auth.User? user =
                                      auth.FirebaseAuth.instance.currentUser;
                                  print(user);
                                  if (user == null) {
                                    Navigator.pop(context);
                                    widget.goToLogin!();
                                    // Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) =>
                                    //         LoginPage(),
                                    //   ),
                                    //   (route) => false,
                                    // );
                                  } else {
                                    await addRequest(
                                        user.uid,
                                        snapshot.data!['startTime'],
                                        snapshot.data!['endTime']);
                                    print("Ended");
                                    Navigator.pop(context);
                                    widget.goToNotifications!();
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  resizeToAvoidBottomInset: false,
                  // floatingActionButton: FloatingActionButton.extended(
                  //     onPressed: () {},
                  //     backgroundColor: Colors.white,
                  //     foregroundColor: Colors.purple,
                  //     icon: const Icon(Icons.book, size: 20.0),
                  //     label: const Text("Book Now"))),
                ));
          }),
    );
  }
}

class VenueDetailTile extends StatelessWidget {
  const VenueDetailTile({
    Key? key,
    required this.iconName,
    required this.title,
  }) : super(key: key);

  final IconData? iconName;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconName,
            color: Colors.black,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
