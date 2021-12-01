import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  CollectionReference venues = FirebaseFirestore.instance.collection('venues');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // List bottomCards = [
  //   HomeBottomCard(
  //     name: "Venue Name",
  //     location: "Mumbai",
  //     price: "2K/hr",
  //     image: AssetImage('images/check.jpg'),
  //     filterName: "Turf",
  //     onClick: () {
  //       print("Filter Name Success!!!");
  //     },
  //   ),
  //   HomeBottomCard(
  //     name: "AOT",
  //     location: "Chennai",
  //     price: "4K/hr",
  //     image: AssetImage('images/aot.jfif'),
  //     filterName: "Banquet",
  //     onClick: () {
  //       print("Filter Name Success!!!");
  //     },
  //   ),
  //   HomeBottomCard(
  //     name: "Yea",
  //     location: "Mumbai",
  //     price: "2K/hr",
  //     image: AssetImage('images/check.jpg'),
  //     filterName: "Turf",
  //     onClick: () {
  //       print("Filter Name Success!!!");
  //     },
  //   ),
  //   HomeBottomCard(
  //     name: "Venue name",
  //     location: "Mumbai",
  //     price: "2K/hr",
  //     image: AssetImage('images/check.jpg'),
  //     filterName: "Turf",
  //     onClick: () {
  //       print("Filter Name Success!!!");
  //     },
  //   ),
  // ];
  Widget build(BuildContext context) {
    return user == null
        ? Container(child: Text("Please Login"))
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                automaticallyImplyLeading: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                toolbarHeight: 30,
                shadowColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "My Favourites",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.favorite),
                          ],
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: users.doc(user!.uid).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!['favourites']
                                  .map<Widget>((venueId) {
                                print(venueId);
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: venues.doc(venueId).snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      return HomeBottomCard(
                                        name: snapshot.data!['name'],
                                        location: snapshot.data!['location'],
                                        price: snapshot.data!['price'],
                                        image: snapshot.data!['venues'].isEmpty
                                            ? AssetImage('images/aot.jfif')
                                                as ImageProvider
                                            : NetworkImage(
                                                snapshot.data!['venues'][0]),
                                        filterName: snapshot.data!['category'],
                                        onClick: () {},
                                      );
                                    });
                              }).toList(),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
