import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  final void Function()? onClick;
  const HomePage({Key? key, this.onClick}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  bool isSelected = false;
  int filter = -1;
  List midCards = [
    [
      'Venue',
      'Mumbai',
      '2K/hr',
      AssetImage('images/check.jpg'),
      "Go to this venue"
    ],
    [
      'Venue2',
      'Mumbai',
      '2K/hr',
      AssetImage('images/check.jpg'),
      "Go to this venue"
    ],
  ];
  List bottomCards = [
    HomeBottomCard(
      name: "Venue Name",
      location: "Mumbai",
      price: "2K/hr",
      image: AssetImage('images/check.jpg'),
      setFlag: false,
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
      setFlag: true,
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
      setFlag: false,
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
      setFlag: false,
      filterName: "Turf",
      onClick: () {
        print("Filter Name Success!!!");
      },
    ),
  ];

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
                  child: Icon(
                    Icons.list,
                  ),
                ),
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
                      filter == 0 ? filter = -1 : filter = 0;
                    });
                  },
                  text: "Turfs",
                  isSelected: filter == 0 ? true : false,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      filter == 1 ? filter = -1 : filter = 1;
                    });
                  },
                  text: "Studio",
                  isSelected: filter == 1 ? true : false,
                ),
                VenueContainer(
                  onPressed: () {
                    setState(() {
                      filter == 2 ? filter = -1 : filter = 2;
                    });
                  },
                  text: "Banquets",
                  isSelected: filter == 2 ? true : false,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment(-0.97, 0),
                child: Text(
                  "Explore",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            //Middle Container Card

            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: CarouselSlider(
                  items: midCards
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: HomeMidCard(
                              name: e[0],
                              location: e[1],
                              price: e[2],
                              image: e[3],
                              onClick: () {
                                print(e);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VenueDetailPage(
                                        name: e[0],
                                        location: e[1],
                                        price: e[2]),
                                  ),
                                );
                              },
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      enlargeCenterPage: true, enableInfiniteScroll: true)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    "Search:",
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
                        "All",
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
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bottomCards.length,
                itemBuilder: (context, index) {
                  return bottomCards[index];
                }),
            //Search
            //Search CARD Below
          ],
        ),
      ),
    );
  }
}
