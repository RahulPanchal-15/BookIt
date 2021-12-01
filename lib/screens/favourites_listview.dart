import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/home.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  List bottomCards = [
    HomeBottomCard(
      name: "Venue Name",
      location: "Mumbai",
      price: "2K/hr",
      image: AssetImage('images/check.jpg'),
      filterName: "Turf",
      onClick: () {
        print("Filter Name Success!!!");
      },
    ),
    HomeBottomCard(
      name: "AOT",
      location: "Chennai",
      price: "4K/hr",
      image: AssetImage('images/aot.jfif'),
      filterName: "Banquet",
      onClick: () {
        print("Filter Name Success!!!");
      },
    ),
    HomeBottomCard(
      name: "Yea",
      location: "Mumbai",
      price: "2K/hr",
      image: AssetImage('images/check.jpg'),
      filterName: "Turf",
      onClick: () {
        print("Filter Name Success!!!");
      },
    ),
    HomeBottomCard(
      name: "Venue name",
      location: "Mumbai",
      price: "2K/hr",
      image: AssetImage('images/check.jpg'),
      filterName: "Turf",
      onClick: () {
        print("Filter Name Success!!!");
      },
    ),
  ];
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Favourites"),
        ),
        body: Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bottomCards.length,
              itemBuilder: (context, index) {
                return bottomCards[index];
              }),
        ),
      ),
    );
  }
}
