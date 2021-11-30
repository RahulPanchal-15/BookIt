import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestCard extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? status;
  final String? userId;
  final String? rId;

  const RequestCard(
      {Key? key,
      this.startTime,
      this.endTime,
      this.date,
      this.userId,
      this.rId,
      this.status})
      : super(key: key);

  _makingPhoneCall(String number) async {
    var url = "tel:+91 $number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<String> getUserName(String userId) async {
  //   DocumentSnapshot user =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //   return user['name'];
  // }

  // Future<String> getUserProfile(String userId) async {
  //   DocumentSnapshot user =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //   return user['profile'];
  // }

  // Future<String> getUserPhone(String userId) async {
  //   DocumentSnapshot user =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //   return user['number'];
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<DocumentSnapshot>(
        stream: users.doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: snapshot.data!['profile'] == ""
                        ? AssetImage('images/aot.jfif') as ImageProvider
                        : NetworkImage(snapshot.data!['profile']),
                  ),
                  title: Text(
                    snapshot.data!['name'],
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text('is requesting a booking for'),
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
                ButtonBar(alignment: MainAxisAlignment.spaceAround, children: [
                  TextButton(
                      onPressed: () {
                        _makingPhoneCall(snapshot.data!['number']);
                      },
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
                    onPressed: () async {
                      CollectionReference requests =
                          FirebaseFirestore.instance.collection('requests');
                      var request = await requests.doc(rId);
                      print(request);

                      request
                          .update({'status': 1})
                          .then((value) => print("Request Status Updated"))
                          .catchError((error) =>
                              print("Failed to update request status: $error"));
                      // Perform some action
                    },
                    child: Row(children: <Widget>[
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
                    onPressed: () async {
                      // Perform some action
                      CollectionReference requests =
                          FirebaseFirestore.instance.collection('requests');
                      var request = await requests.doc(rId);
                      print(request);

                      request
                          .update({'status': 0})
                          .then((value) => print("Request Status Updated"))
                          .catchError((error) =>
                              print("Failed to update request status: $error"));
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
