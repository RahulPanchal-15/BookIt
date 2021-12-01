import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:assignment_practice/widgets/no_data.dart';
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "My Favourites",
                              style:
                                  TextStyle(fontSize: 28, color: Colors.purple),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.favorite,
                              size: 36,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: users.doc(user!.uid).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else if (snapshot.data!['favourites'].length ==
                                0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 170.0),
                                child: kNoData(
                                    text: "No Favourites Yet",
                                    color: Colors.purple),
                              );
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
