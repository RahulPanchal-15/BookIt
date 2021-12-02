// ignore_for_file: prefer_const_constructors
import 'package:assignment_practice/constants.dart';
import 'package:assignment_practice/screens/faq.dart';
import 'package:assignment_practice/screens/requests.dart';
import 'package:assignment_practice/screens/signup_login.dart';
import 'package:assignment_practice/widgets/redirect.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import './owner_register.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import './favourites_listview.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_tile.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatefulWidget {
  final void Function()? onClick;
  final void Function()? changeBottomTab;

  const ProfilePage({Key? key, this.onClick, this.changeBottomTab})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);

    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<MyUser?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<MyUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final MyUser? user = snapshot.data;
          if (user == null) {
            return SafeArea(child: LoginRedirect(callBack: widget.onClick!));
          } else {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: SingleChildScrollView(
                  child: StreamBuilder<DocumentSnapshot?>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 80.0,
                                      backgroundImage:
                                          snapshot.data!['profile'] != null
                                              ? NetworkImage(
                                                  snapshot.data!['profile'])
                                              : AssetImage('images/check.jpg')
                                                  as ImageProvider,
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data!['name'] ?? 'Marcus Ericson',
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
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              child: Column(children: [
                                ProfileCard(
                                    icon: Icons.email,
                                    text: snapshot.data!['email'] ??
                                        "ericson1234@gmail.com"),
                                ProfileCard(
                                    icon: Icons.phone,
                                    text: snapshot.data!['number'] ??
                                        "+1234 567 891"),
                              ]),
                            ),

                            Column(children: [
                              !snapshot.data!['isOwner']
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OwnerRegister(
                                                        goToHome: widget
                                                            .changeBottomTab)));
                                      },
                                      child: ProfileTile(
                                        icon: Icons.add,
                                        text: "Add your own Venue",
                                      ),
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Favourites()),
                                  );
                                },
                                child: ProfileTile(
                                  icon: Icons.favorite,
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
                        );
                      }),
                ),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
