import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,

                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 0.0),
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                          Text(
                            widget.name!,
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.purple,
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
                              size: 35.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          )
                        ]),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          location_pin,
                          color: Colors.black,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                            child: Text(
                              widget.location!,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          article_rounded,
                          color: Colors.black,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                                child: Text(
                                  widget.description ??
                                      "A wholesame turf for football lovers in the heart of Navi Mumbai.",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )))
                      ],
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          monetization_rounded,
                          color: Colors.black,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                            child: Text(
                              widget.price!,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Icon(
                          calendar_outlined,
                          color: Colors.black,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                            child: Text(
                              "Availability",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ))
                      ],
                    )
                  ],
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
