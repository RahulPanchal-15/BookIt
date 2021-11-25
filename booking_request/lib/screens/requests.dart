import 'package:flutter/material.dart';
import '../widgets/request_card.dart';

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({Key? key}) : super(key: key);

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final List<String> imagesList = [
    "https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2015/09/12/Photos/turf-kHJF--621x414@LiveMint.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.white])),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: ,
              body: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            "NMC Turf",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Icon(
                          Icons.task_sharp,
                          color: Colors.white,
                          size: 22.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text(
                              "Booking Requests",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ],
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: 2,
                            padding: const EdgeInsets.only(top: 10.0),
                            itemBuilder: (context, index) {
                              return RequestCard("Rahul");
                            }))
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false)),
    );
  }
}
