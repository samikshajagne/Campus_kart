import 'dart:js';

import 'package:campus_cart/LoginScreen/login_screen.dart';
import 'package:campus_cart/SignupScreen/signup_screen.dart';
import 'package:campus_cart/WelcomeScreen/background.dart';
import 'package:campus_cart/Widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class WelcomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Campus kart',
              style: TextStyle(
                fontSize:60.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontFamily: 'Signatra'
              ),
            ),
            SizedBox(height: size.height * 0.05,),
            Image.asset('assets/icons/chat.png',
            height: size.height * 0.40,),
            RoundedButton(
              text: 'Login',
              press: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder : (context) => LoginScreen()));
              },
            ),
            RoundedButton(
                text: 'Sign Up',
                color: Colors.black54,
                textColor: Colors.white,
                press: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder : (context) => SignupScreen()));
                }
            ),
        ],
      ),
    ),);
  }
}
