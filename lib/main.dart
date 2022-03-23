import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gtaxi/screens/homepage.dart';
import 'package:gtaxi/screens/loginpage.dart';
import 'package:gtaxi/screens/registrationpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "gtaxi",
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAws8QKJR6bNjKum0wYL8OSMvpVj2GDb5c',
      appId: '1:345902005663:android:235c2f599944daed5d11aa',
      messagingSenderId: '345902005663',
      projectId: 'gtaxi-261d7',
      databaseURL:
          'https://gtaxi-261d7-default-rtdb.europe-west1.firebasedatabase.app',
      storageBucket: 'gtaxi-261d7.appspot.com',
    ),
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-regular',
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
