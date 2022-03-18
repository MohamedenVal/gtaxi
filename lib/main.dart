import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

// import 'package:gtaxi/screens/homepage.dart';
import 'package:gtaxi/screens/loginpage.dart';
// import 'package:fireba';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String get name => 'foo';

  FirebaseOptions get firebaseOptions => const FirebaseOptions(
        appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        projectId: 'react-native-firebase-testing',
        messagingSenderId: '448618578101',
      );

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
        // options: DefaultFirebaseConfig.platformOptions,
        options: firebaseOptions);
    if (kDebugMode) {
      print('Initialized default app $app');
    }
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app =
        await Firebase.initializeApp(name: name, options: firebaseOptions);

    if (kDebugMode) {
      print('Initialized $app');
    }
  }

  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    if (kDebugMode) {
      print('Currently initialized apps: $apps');
    }
  }

  void options() {
    final FirebaseApp app = Firebase.app(name);
    final options = app.options;
    if (kDebugMode) {
      print('Current options for app $name: $options');
    }
  }

  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app.delete();
    if (kDebugMode) {
      print('App $name deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-regular',
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
