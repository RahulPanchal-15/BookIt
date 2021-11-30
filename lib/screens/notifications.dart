import 'package:assignment_practice/screens/requests.dart';
import 'package:assignment_practice/screens/user_bookings.dart';
import 'package:assignment_practice/widgets/status_card.dart';
import 'package:flutter/material.dart';
import '../widgets/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  final userRef = FirebaseFirestore.instance.collection('users');
  @override
  int selectedIndex = 0;
  List<String>? labels = ["My Bookings"];
  Widget build(BuildContext context) {
    return user == null
        ? Container(
            child: Text("Login"),
          )
        : StreamBuilder<DocumentSnapshot>(
            stream: userRef.doc(user!.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              bool? isOwner = snapshot.data!['isOwner'];
              if (isOwner!) {
                labels!.add('Incoming Requests');
              }
              return DefaultTabController(
                initialIndex: 0,
                length: labels!.length,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.purple,
                    title: const Text('Notifications'),
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          text: labels![0],
                        ),
                        isOwner
                            ? Tab(
                                text: labels![1],
                              )
                            : Container()
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      UserBookings(),
                      isOwner ? BookingRequestPage() : Container(),
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
