import 'package:assignment_practice/widgets/status_card.dart';
import 'package:flutter/material.dart';
import '../widgets/request_card.dart';
import '../widgets/owner_venue_on_request_page.dart';

class UserBookings extends StatefulWidget {
  const UserBookings({Key? key}) : super(key: key);

  @override
  _UserBookingsState createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  @override
  final List<String> imagesList = [
    "https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/09/12/Photos/turf-kHJF--621x414@LiveMint.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: ,
              body: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: ListView.builder(
                    itemCount: 2,
                    padding: const EdgeInsets.only(top: 0.0),
                    itemBuilder: (context, index) {
                      return StatusCard("Rahul", 2);
                    }),
              ),
              resizeToAvoidBottomInset: false)),
    );
  }
}
