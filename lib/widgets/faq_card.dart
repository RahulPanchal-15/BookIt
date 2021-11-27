import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQCard extends StatefulWidget {
  final String name;

  FAQCard(this.name);

  @override
  State<StatefulWidget> createState() {
    return FAQCardState();
  }
}

class FAQCardState extends State<FAQCard> {
  FAQCardState();

  Widget get FAQCard {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            // leading: CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage(
            //       "https://media.istockphoto.com/photos/learn-to-love-yourself-first-picture-id1291208214?b=1&k=20&m=1291208214&s=170667a&w=0&h=sAq9SonSuefj3d4WKy4KzJvUiLERXge9VgZO-oqKUOo="),
            // ),

            // Icon(Icons.person),
            title: Text(
              'Q. What is BookIt?',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            subtitle: Center(child: Text('- requested by user234')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 18.0),
            child: Flexible(
              child: Text(
                "A. We are a Booking Platform which allows booking of venues on a Fly!",
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FAQCard,
    );
  }
}
