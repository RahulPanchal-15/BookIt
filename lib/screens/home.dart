import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  final void Function()? onClick;
  final void Function()? changeBottomTab;
  const HomePage({Key? key, this.onClick, this.changeBottomTab})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  bool isSelected = false;
  String filter = "Turf";
  final venueRef = FirebaseFirestore.instance.collection('venues');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundImage: AssetImage('images/check.jpg'),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(-0.85, 0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Why Wait ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Book it',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                    TextSpan(
                      text: ' Now!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,

              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              //Extracted Variable for Decoration in
              decoration: kBoxDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    search = value;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search a Venue...",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      filter = filter == "Turf" ? "" : "Turf";
                    });
                  },
                  text: "Turfs",
                  isSelected: filter == "Turf" ? true : false,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      filter = filter == "Studio" ? "" : "Studio";
                    });
                  },
                  text: "Studios",
                  isSelected: filter == "Studio" ? true : false,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      filter = filter == "Banquet" ? "" : "Banquet";
                    });
                  },
                  text: "Banquets",
                  isSelected: filter == "Banquet" ? true : false,
                ),
              ],
            ),

            //Middle Container Card

            // Container(
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            //   child: CarouselSlider(
            //       items: midCards
            //           .map((e) => ClipRRect(
            //                 borderRadius: BorderRadius.circular(8),
            //                 child: HomeMidCard(
            //                   name: e[0],
            //                   location: e[1],
            //                   price: e[2],
            //                   image: e[3],
            //                   onClick: () {
            //                     print(e);
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => VenueDetailPage(
            //                           id: user.uid
            //                             ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ))
            //           .toList(),
            //       options: CarouselOptions(
            //           enlargeCenterPage: true, enableInfiniteScroll: true)),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    search == "" ? "Filter:" : "Showing Results for:",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                    width: 20.0,
                  ),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Text(
                        //if setFlag=1 , then Available
                        search == ""
                            ? (filter == "" ? "All" : "$filter")
                            : search.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            ///////////////////////////////////////
            StreamBuilder<QuerySnapshot>(
                stream: search == ""
                    ? (filter == ""
                        ? venueRef
                            // .orderBy('createdOn', descending: true)
                            .snapshots()
                        : venueRef
                            .where("category", isEqualTo: "${filter}")
                            //.orderBy('createdOn', descending: true)
                            .snapshots())
                    : venueRef
                        .where('name',
                            isGreaterThanOrEqualTo: search.toUpperCase())
                        .where('name', isLessThan: search.toUpperCase() + "z")
                        //.orderBy('createdOn', descending: true)
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
                        print(doc['name']);
                        return HomeBottomCard(
                          name: doc['name'],
                          location: doc['location'],
                          price: doc['price'],
                          image: doc['venues'].isEmpty
                              ? AssetImage('images/aot.jfif') as ImageProvider
                              : NetworkImage(doc['venues'][0]),
                          filterName: doc['category'],
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VenueDetailPage(
                                    id: doc.id,
                                    goToNotifications: widget.changeBottomTab),
                              ),
                            );
                          },
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
            //Search
            //Search CARD Below
          ],
        ),
      ),
    );
  }
}
