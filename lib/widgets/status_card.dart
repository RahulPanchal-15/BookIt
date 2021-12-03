import 'package:assignment_practice/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class StatusCard extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? status;
  final String? ownerId;

  const StatusCard(
      {Key? key,
      this.startTime,
      this.endTime,
      this.date,
      this.ownerId,
      this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    final venueRef = FirebaseFirestore.instance.collection('venues');
    return user == null
        ? Container(child: Text("Please login"))
        : StreamBuilder<DocumentSnapshot>(
            stream: venueRef.doc(ownerId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              print(ownerId);
              print(snapshot.data!['venues']);
              String msgString;
              if (status == 0) {
                msgString = "has rejected your request for";
              } else if (status == 1) {
                msgString = "has accepted your request for";
              } else {
                msgString = "has not responded to your request for";
              }
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(snapshot.data!['venues'][0]),
                      ),

                      // Icon(Icons.person),
                      title: Text(
                        snapshot.data!['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(msgString),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(Icons.calendar_today_rounded,
                                    color: Colors.purple, size: 20),
                              ),
                              Text(
                                date!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Icon(Icons.access_time_filled_sharp,
                                    color: Colors.purple),
                              ),
                              Text(
                                '$startTime - $endTime',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              primary: status == 0
                                  ? Colors.red[800]
                                  : status == 1
                                      ? Colors.green
                                      : Colors.yellow[900],
                            ),
                            onPressed: () {},
                            child: Row(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                child: Icon(
                                  status == 0
                                      ? Icons.cancel
                                      : status == 1
                                          ? Icons.check
                                          : Icons.pending,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                status == 0
                                    ? "Rejected"
                                    : status == 1
                                        ? "Accepted"
                                        : "Pending",
                                style: TextStyle(
                                    color: Colors.white,
                                    // widget.status == 0
                                    //     ? Colors.red
                                    //     : widget.status == 1
                                    //         ? Colors.green
                                    //         : Colors.yellow,
                                    fontSize: 18),
                              ),
                            ]),
                          ),
                          TextButton(
                            onPressed: () async {
                              _makingPhoneCall(snapshot.data!['contact']);
                            },
                            child: Row(children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                child: Icon(
                                  Icons.call,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Call',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ]),
                          ),
                        ])
                  ]));
            });
  }

  _makingPhoneCall(String number) async {
    var url = 'tel:+91 $number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
