import 'package:assignment_practice/constants.dart';
import 'package:assignment_practice/screens/requests.dart';
import 'package:assignment_practice/screens/user_bookings.dart';
import 'package:assignment_practice/widgets/redirect.dart';
import 'package:assignment_practice/widgets/status_card.dart';
import 'package:flutter/material.dart';
import '../widgets/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Notifications extends StatefulWidget {
  final void Function()? redirect;
  final void Function()? goToLogin;
  const Notifications({Key? key, this.redirect, this.goToLogin})
      : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  final userRef = FirebaseFirestore.instance.collection('users');
  @override
  int selectedIndex = 0;
  // List<String>? labels = ["My Bookings"];
  Widget build(BuildContext context) {
    return user == null
        ? SafeArea(
            child: LoginRedirect(callBack: widget.goToLogin!),
          )
        : StreamBuilder<DocumentSnapshot>(
            stream: userRef.doc(user!.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              bool? isOwner = snapshot.data!['isOwner'];
              return DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.purple,
                    title: const Text('Notifications'),
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          text: "My Bookings",
                        ),
                        Tab(
                          text: "Incoming Requests",
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      UserBookings(),
                      isOwner == null
                          ? Container()
                          : isOwner
                              ? BookingRequestPage()
                              : Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.purple.shade800,
                                          // Colors.purple.shade600,
                                          Colors.purple.shade400,
                                          Colors.purple.shade200,
                                          // Colors.purple.shade100,
                                          Colors.deepPurpleAccent,
                                        ]),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Are you a Venue Owner?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24))),
                                            onPressed: () {
                                              widget.redirect!();
                                            },
                                            child: Text(
                                              "Register Venue",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                    ],
                  ),
                ),
              );
            });
    // return Container(
    //   child: CustomToggle(
    //     selectedIndex: selectedIndex,
    //     onToggle: (index) {
    //       setState(() {
    //         selectedIndex = index;
    //       });
    //     },
    //     labels: labels!,
    //   ),
    // );
    // // return Container();
  }
}
