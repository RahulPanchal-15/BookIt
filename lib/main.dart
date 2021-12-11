import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

//screens
import 'splash_screen.dart';
import './services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<MyAuth>(
        //   create: (_) => MyAuth(),
        // ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        title: 'Book It',
        home: SplashScreen(),
      ),
    );
  }
}
