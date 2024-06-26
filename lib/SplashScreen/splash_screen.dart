import 'dart:async';

import 'package:campus_cart/Homescreen/home_screen.dart';
import 'package:campus_cart/Homescreen/home_screen.dart';
import 'package:campus_cart/WelcomeScreen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Homescreen/home_screen.dart';

class SplashScreen extends StatefulWidget {

  @override

  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () async {
      // Check if the current user is null
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  void initStateAsync() async {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
         color: Colors.white
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/shop.png', width: 200, height: 200),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Sell, Purchase or Exchange within the\n Campus of VCET",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Varela',
                  fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
