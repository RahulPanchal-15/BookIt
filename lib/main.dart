import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Profile'),
          backgroundColor: Colors.purple,
        ),
        body: ProfilePage(),
      ),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  // const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/check.jpg'),
              ),
            ),
          ),
          Text(
            'Marcus Ericson',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'NotoSans',
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 150.0,
            child: Divider(
              color: Colors.purple[900],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.purpleAccent, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            // color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 18.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.1),
              //Replaced with ListTile Widget (earlier Row WIdget)
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal.shade800,
                ),
                title: Text(
                  "ericsonn324@gmail.com",
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.purpleAccent, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            // color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 18.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.1),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.teal.shade800,
                ),
                title: Text(
                  "+91 1234 567 923",
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "My BookIt Info:",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 18.0,
          //     ),
          //   ),
          // ),
          ListTile(
            leading: Icon(
              Icons.check_box,
              color: Colors.black,
            ),
            title: Text(
              "My Bookings",
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            title: Text(
              "My Favorites",
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.black,
            ),
            title: Text(
              "FAQ",
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
