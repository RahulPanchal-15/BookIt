import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusCard extends StatefulWidget {
  final String name;
  final int status; //0-pending, 1-accepted, 2-rejected

  StatusCard(this.name, this.status);

  @override
  State<StatefulWidget> createState() {
    return StatusCardState();
  }
}

_makingPhoneCall() async {
  const url = 'tel:+91 9167979960';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class StatusCardState extends State<StatusCard> {
  StatusCardState();

  Widget get StatusCard {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: widget.status == 1
            ? Colors.green.shade200
            : widget.status == 2
                ? Colors.red.shade400
                : Colors.yellow.shade200,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://media.istockphoto.com/photos/learn-to-love-yourself-first-picture-id1291208214?b=1&k=20&m=1291208214&s=170667a&w=0&h=sAq9SonSuefj3d4WKy4KzJvUiLERXge9VgZO-oqKUOo="),
            ),

            // Icon(Icons.person),
            title: Text(
              'NMC Turf',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text('has accepted your booking for'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.calendar_today_rounded,
                          color: Colors.purple, size: 20),
                    ),
                    Text(
                      '22nd November',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: Icon(Icons.access_time_filled_sharp,
                          color: Colors.purple),
                    ),
                    Text(
                      '19:00 - 20:00',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ButtonBar(alignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
                onPressed: _makingPhoneCall,
                child: Row(children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Call',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ])),
          ])
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatusCard,
    );
  }
}
