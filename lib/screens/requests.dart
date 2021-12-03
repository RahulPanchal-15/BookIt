import 'package:assignment_practice/constants.dart';
import 'package:assignment_practice/widgets/custom_loader.dart';
import 'package:assignment_practice/widgets/no_data.dart';
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
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: kBoxGradient,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: ,
              body: user != null
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: venues.doc(user!.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CustomLoader(color: Colors.blue, size: 28);
                        }
                        print(snapshot.data!['venues']);
                        return Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    OwnerVenueCard(
                                      image:
                                          snapshot.data!['venues'].length == 0
                                              ? AssetImage('images/aot.jfif')
                                                  as ImageProvider
                                              : NetworkImage(
                                                  snapshot.data!['venues'][0]),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data!['name'] ??
                                              "No name found",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                ),

                                const Divider(
                                  thickness: 0,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: requestRef
                                        .where("ownerId", isEqualTo: user!.uid)
                                        .where('status', isEqualTo: 2)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        print(snapshot.hasData);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: Center(
                                            child: CustomLoader(
                                                color: Colors.blue, size: 28),
                                          ),
                                        );
                                      } else if (snapshot.data!.docs.length ==
                                          0) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: kNoData(
                                              text: "No Incoming Requests",
                                              color: Colors.white),
                                        );
                                      } else {
                                        print(snapshot.data!.docs);
                                        return ListView(
                                          shrinkWrap: true,
                                          children:
                                              snapshot.data!.docs.map((doc) {
                                            return RequestCard(
                                                startTime: doc['startTime'],
                                                endTime: doc['endTime'],
                                                userId: doc['userId'],
                                                status: doc['status'],
                                                date: doc['date'],
                                                rId: doc.id);
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
                        );
                      })
                  : Container(child: Text("Please Login")),
              resizeToAvoidBottomInset: false)),
    );
  }
}
