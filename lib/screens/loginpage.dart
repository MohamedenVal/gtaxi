// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtaxi/brand_colors.dart';
import 'package:gtaxi/screens/registrationpage.dart';
import 'package:gtaxi/widgets/progressdialog.dart';

import '../widgets/taxibutton.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String? title) {
    final snackBar = SnackBar(
      content: Text(
        title ?? 'Something went wrong!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    // show wait dialogur
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: "Loging in"),
    );

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Take the user to home page
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      final user = userCredential.user;
      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("users/${user.uid}");

        userRef.once().then((value) {
          if (value.snapshot.value != null) {
            // Take the user to home page
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.id, (route) => false);
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      // Check error and display message
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar('Wrong password provided for that user.');
      }
    }

    // Take the user to home page
    // Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Image(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Sign In as a Rider ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-blod'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TaxiButton(
                        title: 'LOGIN',
                        color: BrandColors.colorGreen,
                        onPressed: () async {
                          // check network availability
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            // I am connected to a mobile network. and I am connected to a wifi network.
                            showSnackBar("No internet connection!");
                            return;
                          }

                          if (!emailController.text.contains('@')) {
                            showSnackBar(
                                "Please provide a valid email address ");
                            return;
                          }

                          if (passwordController.text.length < 8) {
                            showSnackBar("Please provide a valid password");
                            return;
                          }

                          login();
                        },
                      )
                    ],
                  ),
                ),
                TextButton(
                  child: Text('Don\'t have an account, sign up here'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationPage.id, (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
