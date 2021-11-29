import 'package:flutter/material.dart';
import '../widgets/request_card.dart';
import '../widgets/owner_venue_on_request_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({Key? key}) : super(key: key);

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  final requestRef = FirebaseFirestore.instance.collection('requests');
  CollectionReference venues = FirebaseFirestore.instance.collection('venues');

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: OwnerVenueCard(
                          image: NetworkImage(
                              "https://4.img-dpreview.com/files/p/articles/5081755051/0652566517.jpeg"),
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              "NMC Turf",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(
                              Icons.task_sharp,
                              color: Colors.white,
                              size: 22.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            Text(
                              "Booking Requests",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: requestRef
                            .where("ownerId", isEqualTo: user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            print(snapshot.hasData);
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            print(snapshot);
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((doc) {
                                return RequestCard(
                                  startTime: doc['startTime'],
                                  endTime: doc['endTime'],
                                  userId: doc['userId'],
                                  status: doc['status'],
                                  date: doc['date'],
                                );
                              }).toList(),
                            );
                          }
                          // return ListView.builder(
                          //     physics: NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemCount: bottomCards.length,
                          //     itemBuilder: (context, index) {
                          //       return bottomCards[index];
                          //     });
                        }),
                    //     Expanded(
                    //         child: ListView.builder(
                    //             itemCount: 2,
                    //             padding: const EdgeInsets.only(top: 0.0),
                    //             itemBuilder: (context, index) {
                    //               return RequestCard("Rahul");
                    //             }))
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false)),
    );
  }
}
