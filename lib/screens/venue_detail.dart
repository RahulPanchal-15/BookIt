import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/select_time.dart';
import '../constants.dart';

class VenueDetailPage extends StatefulWidget {
  final String? name;
  final String? location;
  final String? description;
  final String? price;

  const VenueDetailPage(
      {Key? key, this.name, this.location, this.description, this.price})
      : super(key: key);

  @override
  _VenueDetailPageState createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  bool isPressed = false;
  String? search;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final List<String> imagesList = [
    "https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/09/12/Photos/turf-kHJF--621x414@LiveMint.jpg",
  ];

  static const IconData location_pin =
      IconData(58284, fontFamily: 'MaterialIcons');
  static const IconData article_rounded =
      IconData(0xf580, fontFamily: 'MaterialIcons');
  static const IconData monetization_rounded =
      IconData(63695, fontFamily: 'MaterialIcons');
  static const IconData star_outlined =
      IconData(58874, fontFamily: 'MaterialIcons');
  static const IconData calendar_outlined =
      IconData(57634, fontFamily: 'MaterialIcons');
  static const IconData call_outlined =
      IconData(57638, fontFamily: 'MaterialIcons');

  var kBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Colors.purple, spreadRadius: 1),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white])),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: ,
              body: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Container(
                      //   width: MediaQuery.of(context).size.width,

                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15.0, vertical: 0.0),
                      //   //Extracted Variable for Decoration in
                      //   decoration: kBoxDecoration.copyWith(
                      //     borderRadius: BorderRadius.circular(20.0),
                      //   ),
                      //   margin: const EdgeInsets.symmetric(
                      //     vertical: 15.0,
                      //     horizontal: 10.0,
                      //   ),
                      //   child: TextField(
                      //     textAlignVertical: TextAlignVertical.center,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         print(value);
                      //         search = value;
                      //       });
                      //     },
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: "Search a Venue...",
                      //       suffixIcon: Icon(Icons.search),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: CarouselSlider(
                            items: imagesList
                                .map((e) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Image.network(e,
                                              width: 1000,
                                              height: 200,
                                              fit: BoxFit.cover)
                                        ],
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true)),
                      ),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                widget.name!,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                              },
                              child: Icon(
                                isPressed
                                    ? CupertinoIcons.heart_fill
                                    : Icons.favorite_outline,
                                color: isPressed
                                    ? Colors.redAccent[700]
                                    : Colors.black,
                                size: 28.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            )
                          ]),
                      const Divider(),
                      VenueDetailTile(
                          iconName: location_pin, title: widget.location!),
                      VenueDetailTile(
                          iconName: article_rounded,
                          title: widget.description ??
                              "A wholesame turf for football lovers in the heart of Navi Mumbai."),
                      VenueDetailTile(
                          iconName: monetization_rounded, title: widget.price!),
                      VenueDetailTile(
                          iconName: calendar_outlined,
                          title: "Availability: 09:00 - 10:00"),
                      const Divider(
                        thickness: 0,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select Slot:",
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 16),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.schedule),
                                          TextButton(
                                            onPressed: () {
                                              selectTime(context, (time) {
                                                setState(() {
                                                  startTime = time;
                                                });
                                              }, startTime);
                                            },
                                            child: Text(
                                              startTime != null
                                                  ? "${startTime!.hour.toString()} : ${startTime!.minute.toString()}"
                                                  : "Start",
                                              style: TextStyle(
                                                  color: Colors.purple),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("TO"),
                                      Row(
                                        children: [
                                          Icon(Icons.schedule_outlined),
                                          TextButton(
                                            onPressed: () {
                                              selectTime(context, (time) {
                                                setState(() {
                                                  endTime = time;
                                                });
                                              }, endTime);
                                            },
                                            child: Text(
                                              endTime != null
                                                  ? "${endTime!.hour.toString()} : ${endTime!.minute.toString()}"
                                                  : "End",
                                              style: TextStyle(
                                                  color: Colors.purple),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      const Divider(
                        thickness: 0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Book Now!"),
                          ),
                          onPressed: () {},
                          style: kButtonStyle.copyWith(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 10.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  icon: const Icon(call_outlined, size: 20.0),
                  label: const Text("Call")))),
    );
  }
}

class VenueDetailTile extends StatelessWidget {
  const VenueDetailTile({
    Key? key,
    required this.iconName,
    required this.title,
  }) : super(key: key);

  final IconData? iconName;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconName,
            color: Colors.black,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
