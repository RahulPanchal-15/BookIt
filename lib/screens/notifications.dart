import 'package:assignment_practice/screens/requests.dart';
import 'package:assignment_practice/screens/user_bookings.dart';
import 'package:assignment_practice/widgets/status_card.dart';
import 'package:flutter/material.dart';
import '../widgets/toggle_switch.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  int selectedIndex = 0;
  List<String>? labels = ["My Bookings", "My Requests"];
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Notifications'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "Incoming Requests",
              ),
              Tab(
                text: "My Bookings",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BookingRequestPage(),
            UserBookings(),
          ],
        ),
      ),
    );
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
