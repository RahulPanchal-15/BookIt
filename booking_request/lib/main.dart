import 'package:flutter/material.dart';
import 'theme.dart';
import './screens/requests.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: applicationTheme(context),
      initialRoute: '/bookingRequest',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/bookingRequest': (context) => const BookingRequestPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/second': (context) => const OwnerRegister(),
      },
    );
  }
}
