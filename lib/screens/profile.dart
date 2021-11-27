// ignore_for_file: prefer_const_constructors
import 'package:assignment_practice/screens/faq.dart';
import 'package:assignment_practice/screens/requests.dart';
import 'package:assignment_practice/screens/signup_login.dart';
import 'package:provider/provider.dart';

import './owner_register.dart';
import '../models/user_model.dart';
import '../services/my_auth.dart';
import '../services/auth_service.dart';
import './favourites_listview.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_tile.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatefulWidget {
  final void Function()? onClick;
  const ProfilePage({Key? key, this.onClick}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    return StreamBuilder<MyUser?>(
      stream: _auth.user,
      builder: (_, AsyncSnapshot<MyUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final MyUser? user = snapshot.data;
          return user == null
              ? Center(
                  child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.purple),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    widget.onClick!();
                  },
                  child: Text("Please Login First"),
                ))
              : SafeArea(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                          AssetImage('images/check.jpg'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Marcus Ericson',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'NotoSans',
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.0,
                                  width: 150.0,
                                  child: Divider(
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ],
                            ),

                            //Used Extract Widget for this
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(children: [
                                ProfileCard(
                                    icon: Icons.email,
                                    text: "ericson1234@gmail.com"),
                                ProfileCard(
                                    icon: Icons.phone, text: "+1234 567 891"),
                              ]),
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

                            Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookingRequestPage()));
                                },
                                child: ProfileTile(
                                  icon: Icons.place,
                                  text: " My Venue",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OwnerRegister()));
                                },
                                child: ProfileTile(
                                  icon: Icons.add,
                                  text: " Add your own Venue",
                                ),
                              ),

                              //Card in which there will be Venue Image and name
                              ProfileTile(
                                icon: Icons.favorite,
                                text: "My Bookings",
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Favourites()),
                                  );
                                },
                                child: ProfileTile(
                                  icon: Icons.check_box,
                                  text: "My Favorites",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("FAQ");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FAQ(),
                                    ),
                                  );
                                },
                                child: ProfileTile(
                                  icon: Icons.question_answer,
                                  text: " FAQ",
                                ),
                              ),
                              ProfileTile(
                                icon: Icons.settings,
                                text: "Settings",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    // Provider.of<MyAuth>(context, listen: false)
                                    //     .setIsDone(false);
                                    // Provider.of<MyAuth>(context, listen: false)
                                    //     .setUser(null);
                                    _auth.signOut();
                                    widget.onClick!();
                                  } catch (err) {
                                    print("Error");
                                    print(err);
                                  }
                                },
                                child: ProfileTile(
                                  icon: Icons.logout,
                                  text: "Logout",
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
