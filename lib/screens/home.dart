import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:assignment_practice/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  final void Function()? onClick;
  final void Function()? changeBottomTab;
  final void Function()? goToLogin;
  final void Function()? goToProfile;
  const HomePage(
      {Key? key,
      this.onClick,
      this.changeBottomTab,
      this.goToLogin,
      this.goToProfile})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  int selected = 0;
  List<String> filters = ["All", "Turf", "Studio", "Banquet"];
  // String filter = "All Venues";
  final venueRef = FirebaseFirestore.instance.collection('venues');
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Center(
            //   child: Text(
            //     "BookIt",
            //     style: TextStyle(
            //         color: Colors.purple,
            //         fontSize: 28.0,
            //         // fontWeight: FontWeight.bold,
            //         fontFamily: 'Pacifico'),
            //   ),
            // ),
            Align(
              alignment: Alignment(-0.85, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BookIt",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 28.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          user == null
                              ? widget.goToLogin!()
                              : widget.goToProfile!();
                        },
                        child: user == null
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,
                                radius: 20.0,
                                backgroundImage:
                                    AssetImage('images/user_icon.png'),
                              )
                            : StreamBuilder<DocumentSnapshot>(
                                stream: users.doc(user!.uid).snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.white,
                                      radius: 20.0,
                                      backgroundImage:
                                          AssetImage('images/user_icon.png'),
                                    );
                                  }
                                  return CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    backgroundImage:
                                        snapshot.data!['profile'] == ""
                                            ? AssetImage('images/user_icon.png')
                                                as ImageProvider
                                            : NetworkImage(
                                                snapshot.data!['profile']),
                                  );
                                }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.85, 0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Why Wait ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SourceSansPro',
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Book it',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SourceSansPro',
                        color: Colors.purple,
                      ),
                    ),
                    TextSpan(
                      text: ' Now!',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SourceSansPro',
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
                autofocus: false,
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
                      selected = 0;
                    });
                  },
                  text: "All Venues",
                  isSelected: selected == 0,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                  text: "Turfs",
                  isSelected: selected == 1,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                  text: "Studios",
                  isSelected: selected == 2,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      selected = 3;
                    });
                  },
                  text: "Banquets",
                  isSelected: selected == 3,
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
                        search == "" ? filters[selected] : search,
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
                    ? (selected == 0
                        ? venueRef
                            // .orderBy('createdOn', descending: true)
                            .snapshots()
                        : venueRef
                            .where("category", isEqualTo: filters[selected])
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 180.0),
                        child: CustomLoader(
                          color: Colors.blue,
                          size: 28,
                        ),
                      ),
                    );
                  } else if (snapshot.data!.docs.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Column(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.black, size: 40),
                          Text(
                            "No Results Found",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    print(snapshot);
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc) {
                        print(doc['name']);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: HomeBottomCard(
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
                                    goToNotifications: widget.changeBottomTab,
                                    goToLogin: widget.goToLogin,
                                  ),
                                ),
                              );
                            },
                          ),
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
