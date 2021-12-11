import 'package:assignment_practice/widgets/custom_loader.dart';
import 'package:assignment_practice/widgets/no_data.dart';
import 'package:assignment_practice/widgets/status_card.dart';
import 'package:flutter/material.dart';
import '../widgets/request_card.dart';
import '../widgets/owner_venue_on_request_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class UserBookings extends StatefulWidget {
  const UserBookings({Key? key}) : super(key: key);

  @override
  _UserBookingsState createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  @override
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  final requestRef = FirebaseFirestore.instance.collection('requests');
  CollectionReference venues = FirebaseFirestore.instance.collection('venues');
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  final List<String> imagesList = [
    "https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/09/12/Photos/turf-kHJF--621x414@LiveMint.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: kBoxGradient,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: ,
              body: user == null
                  ? Container(
                      child: CustomLoader(color: Colors.blue, size: 28),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: requestRef
                          .where('userId', isEqualTo: user!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CustomLoader(color: Colors.blue, size: 28);
                        } else if (snapshot.data!.docs.length == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 170.0),
                            child: kNoData(
                                text: "No Bookings Requested",
                                color: Colors.white),
                          );
                        }
                        return Container(
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((doc) {
                                return StatusCard(
                                  ownerId: doc['ownerId'],
                                  status: doc['status'],
                                  date: doc['date'],
                                  startTime: doc['startTime'],
                                  endTime: doc['endTime'],
                                );
                              }).toList(),
                            ));
                      }),
              resizeToAvoidBottomInset: false)),
    );
  }
}
