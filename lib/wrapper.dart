import 'package:assignment_practice/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//screens
import 'screens/owner_register.dart';
import 'screens/main_screen.dart';
import 'screens/signup_login.dart';
import 'services/auth_service.dart';
import 'models/user_model.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<MyUser?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<MyUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final MyUser? user = snapshot.data;
          return MaterialApp(
            initialRoute: user == null ? '/login' : '/main',
            routes: {
              '/main': (context) => MainScreen(),
              '/login': (context) => const LoginPage(),
              '/owner': (context) => const OwnerRegister(),
            },
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
