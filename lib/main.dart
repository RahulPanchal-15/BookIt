import 'package:flutter/material.dart';
import 'package:flutter_application_1_/constants.dart';
import './widgets/venue_containers.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home Page',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.purple,
        ),
        body: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
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
                    TextSpan(text: 'Why Wait '),
                    TextSpan(
                      text: 'Book it',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                    TextSpan(text: ' Now!'),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              //Extracted Variable for Decoration in
              decoration: kBoxDecoration.copyWith(
                borderRadius: BorderRadius.circular(13.0),
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search a Venue",
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                VenueContainer(
                  text: "Turfs",
                ),
                VenueContainer(
                  text: "Studio",
                ),
                VenueContainer(
                  text: "Banquets",
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //For Rounding of image inside Container(sync card and image borderradius)
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Ink.image(
                            // fit: BoxFit.fitWidth,
                            height: 100,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              'images/check.jpg',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            // child: Text("Text checl!"),
                          ),
                        ],
                      ),
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Venue Name"),
                                //For Horizontal line
                                SizedBox(
                                  height: 15.0,
                                  width: 75.0,
                                  child: Divider(
                                    color: Colors.purple,
                                  ),
                                ),
                                Text(
                                  "Location: Mumbai",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "Price: 2k",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            FlatButton(
                              color: Colors.purple,
                              onPressed: () {},
                              child: Text(
                                "Book!",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(8.0),
                      ),
                    ],
                  ),
                ),
              ),
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
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)),
                        ),
                      ),
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///////////////////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //For Rounding of image inside Container(sync card and image borderradius)
                clipBehavior: Clip.antiAlias,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Image(
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          image: AssetImage(
                            'images/check.jpg',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Venue Name"),
                              //For Horizontal line
                              SizedBox(
                                height: 10.0,
                                width: 75.0,
                                child: Divider(
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Location: Mumbai",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              Text(
                                "Price: 2k",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Padding(
                    //   padding: EdgeInsets.all(8.0),

                    //   // child: Text("Text checl!"),
                    // ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)),
                              ),
                            ),
                            child: Text(
                              "Turf",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.0,
                          width: 75.0,
                        ),
                        Container(
                          height: 16,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade800),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "Booked",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Search

            //Search CARD Below
          ],
        ),
      ),
    );
  }
}

// class ProfilePage extends StatefulWidget {
//   // const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Center(
//               child: CircleAvatar(
//                 radius: 30.0,
//                 backgroundImage: AssetImage('images/check.jpg'),
//               ),
//             ),
//           ),
//           Text(
//             'Marcus Ericson',
//             style: TextStyle(
//               fontSize: 15.0,
//               color: Colors.black,
//               fontFamily: 'NotoSans',
//               // fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//             width: 150.0,
//             child: Divider(
//               color: Colors.purple[900],
//             ),
//           ),
//           //Used Extract Widget for this
//           ProfileCard(icon: Icons.email, text: "ericson1234@gmail.com"),
//           ProfileCard(icon: Icons.phone, text: "+1234 567 891"),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Text(
//           //     "My BookIt Info:",
//           //     style: TextStyle(
//           //       fontWeight: FontWeight.bold,
//           //       fontSize: 18.0,
//           //     ),
//           //   ),
//           // ),
//           ProfileTile(
//             icon: Icons.favorite,
//             text: "My Bookings",
//           ),
//           ProfileTile(
//             icon: Icons.check_box,
//             text: "My Favorites",
//           ),
//           ProfileTile(
//             icon: Icons.question_answer,
//             text: " FAQ",
//           ),
//           ProfileTile(
//             icon: Icons.settings,
//             text: "Settings",
//           ),
//           ProfileTile(
//             icon: Icons.logout,
//             text: "Logout",
//           ),
//         ],
//       ),
//     );
//   }
// }

// SafeArea(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//               // height: MediaQuery.of(context).size.height,
//               height: 100.0,
//               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(color: Colors.purple, spreadRadius: 1.5),
//                 ],
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Expanded(flex: 1, child: Container()),
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       children: <Widget>[
//                         Container(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
