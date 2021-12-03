import 'package:assignment_practice/screens/venue_detail.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:get/get.dart';
import '../widgets/venue_containers.dart';
import '../widgets/home_mid_card.dart';
import '../widgets/home_bottom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/request_card.dart';
import '../screens/home.dart';
import '../widgets/faq_card.dart';
import 'package:flutter/material.dart';
import '../widgets/request_card.dart';
import '../widgets/owner_venue_on_request_page.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade800,
                  // Colors.purple.shade600,
                  Colors.purple.shade400,
                  Colors.purple.shade200,
                  // Colors.purple.shade100,
                  Colors.deepPurpleAccent
                ],
              ),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  margin: const EdgeInsets.fromLTRB(15, 4, 15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ]),
                      Text(
                        "BookIt",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico'),
                      ),
                      Align(
                        alignment: Alignment(-0.85, 0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Text(
                            "FAQ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'SourceSansPro',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: 4,
                              padding: const EdgeInsets.only(top: 4.0),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FAQCard("Rishabh"),
                                );
                              }))
                    ],
                  ),
                ),
                resizeToAvoidBottomInset: false)),
      ),
    );
  }
}
