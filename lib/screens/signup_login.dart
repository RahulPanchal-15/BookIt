import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'owner_register.dart';
import '../services/auth_service.dart';
import '../constants.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_password.dart';
import '../widgets/toggle_switch.dart';
import '../widgets/pick_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String cPassword = '';
  String name = "";
  String mobileNumber = "";
  File? profileImage;

  int selection = 0;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.purple,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          child: Text("Go to Home"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.03,
                        horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomToggle(
                            selectedIndex: selection,
                            labels: ["Signup", "Login"],
                            onToggle: (index) => {
                              setState(() {
                                selection = index;
                              })
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30.0),
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: "Enter Email or Username",
                                  onChange: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                                selection == 0
                                    ? CustomTextField(
                                        hintText: "Your Name",
                                        onChange: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                      )
                                    : Container(),
                                selection == 0
                                    ? CustomTextField(
                                        hintText: "Mobile Number",
                                        onChange: (value) {
                                          setState(() {
                                            mobileNumber = value;
                                          });
                                        },
                                      )
                                    : Container(),
                                CustomPasswordField(
                                  hintText: "Password",
                                  showPass: false,
                                  onChange: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                                selection == 0
                                    ? CustomPasswordField(
                                        hintText: "Confirm Password",
                                        showPass: false,
                                        onChange: (value) {
                                          setState(() {
                                            cPassword = value;
                                          });
                                        },
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: const Text(
                                                  'Forgot Password?'),
                                            ),
                                            onDoubleTap: () {
                                              print(
                                                  "Try to remember it, we can't help");
                                            },
                                          )
                                        ],
                                      ),
                                selection == 0
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Upload Profile Photo",
                                            ),
                                            IconButton(
                                              onPressed: () => {
                                                pickImage(ImageSource.gallery,
                                                    (image) {
                                                  setState(() {
                                                    profileImage = image;
                                                  });
                                                })
                                              },
                                              icon: Icon(
                                                Icons.add_a_photo,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                (selection == 0 && profileImage != null)
                                    ? Image(
                                        image: FileImage(profileImage!),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: kButtonStyle,
                                      onPressed: selection == 0
                                          ? () async {
                                              if ((email != '' &&
                                                      password != '') &&
                                                  (password == cPassword)) {
                                                try {
                                                  final user = await _auth
                                                      .createUserWithEmailAndPassword(
                                                    email,
                                                    password,
                                                  );
                                                  if (user != null) {
                                                    // Provider.of<MyAuth>(context,
                                                    //         listen: false)
                                                    //     .setUser(user);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const OwnerRegister(),
                                                      ),
                                                    );
                                                  }
                                                } catch (err) {
                                                  print(err);
                                                }
                                              }
                                            }
                                          : () async {
                                              if (email != '' &&
                                                  password != '') {
                                                try {
                                                  final user = await _auth
                                                      .signInWithEmailAndPassword(
                                                    email,
                                                    password,
                                                  );
                                                  if (user != null) {
                                                    // MyUser user = MyUser(result.user!.uid,
                                                    //     result.user!.email);
                                                    // Provider.of<MyAuth>(context,
                                                    //         listen: false)
                                                    //     .setUser(user);

                                                    // Navigator.pushReplacement(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         const OwnerRegister(),
                                                    //   ),
                                                    // );
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, '/main');
                                                  }
                                                } catch (err) {
                                                  print(err);
                                                }
                                              }
                                            },
                                      child: Text(
                                          selection == 0 ? 'Sign Up' : 'Login'),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selection = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("images/google_icon.png"),
                                    ),
                                  ),
                                  width: 50,
                                  height: 40,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
