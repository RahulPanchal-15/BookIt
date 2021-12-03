import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:assignment_practice/widgets/custom_loader.dart';
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
import '../widgets/redirect.dart';

class Favourites extends StatefulWidget {
  final void Function()? changeBottomTab;
  final void Function()? goToLogin;

  const Favourites({
    Key? key,
    this.changeBottomTab,
    this.goToLogin,
  }) : super(key: key);
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
        ? Container(child: LoginRedirect())
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
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "BookIt",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "My Favourites",
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro  ',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: users.doc(user!.uid).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CustomLoader(color: Colors.blue, size: 28);
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
                                        return CustomLoader(
                                            color: Colors.blue, size: 28);
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
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VenueDetailPage(
                                                id: venueId,
                                                goToNotifications:
                                                    widget.changeBottomTab,
                                                goToLogin: widget.goToLogin,
                                              ),
                                            ),
                                          );
                                        },
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
