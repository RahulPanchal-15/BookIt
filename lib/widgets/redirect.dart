import 'package:flutter/material.dart';
import '../constants.dart';

class LoginRedirect extends StatelessWidget {
  final void Function()? callBack;
  const LoginRedirect({
    Key? key,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: kBoxGradient,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "BookIt",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 52.0,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                // Text(
                //   "Login to proceed",
                //   style: TextStyle(color: Colors.white, fontSize: 22),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(24))),
                            style: kButtonStyle,
                            onPressed: () {
                              callBack!();
                            },
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
