import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestCard extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? status;
  final String? userId;

  const RequestCard(
      {Key? key,
      this.startTime,
      this.endTime,
      this.date,
      this.userId,
      this.status})
      : super(key: key);

  _makingPhoneCall(number) async {
    const url = "tel:+91 9167979960";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getUserName(String userId) async {
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return user['name'];
  }

  Future<String> getUserProfile(String userId) async {
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return user['profile'];
  }

  Future<String> getUserPhone(String userId) async {
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return user['number'];
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<Object>(
        stream: users.doc(userId).snapshots(),
        builder: (context, snapshot) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/photos/learn-to-love-yourself-first-picture-id1291208214?b=1&k=20&m=1291208214&s=170667a&w=0&h=sAq9SonSuefj3d4WKy4KzJvUiLERXge9VgZO-oqKUOo="),
                  ),

                  // Icon(Icons.person),
                  title: Text(
                    'Rishabh Kothari',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text('is requesting a booking for'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.calendar_today_rounded,
                                color: Colors.purple, size: 20),
                          ),
                          Text(
                            '22nd November',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(Icons.access_time_filled_sharp,
                                color: Colors.purple),
                          ),
                          Text(
                            '19:00 - 20:00',
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
                ButtonBar(alignment: MainAxisAlignment.spaceAround, children: [
                  TextButton(
                      onPressed: _makingPhoneCall(userId),
                      child: Row(children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                          child: Icon(
                            Icons.call,
                            size: 18,
                          ),
                        ),
                        Text('Call'),
                      ])),
                  TextButton(
                    onPressed: () {
                      // Perform some action
                    },
                    child: Row(children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Icon(
                          Icons.check_circle_sharp,
                          size: 18,
                          color: Colors.green,
                        ),
                      ),
                      Text('Accept'),
                    ]),
                  ),
                  TextButton(
                    onPressed: () {
                      // Perform some action
                    },
                    child: Row(children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                      Text('Reject'),
                    ]),
                  ),
                ])
              ]));
        });
  }
}
