
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
            SizedBox(height: 100),
            Text(
              'Campus kart',
              style: TextStyle(
                fontSize:80.0,
                fontWeight: FontWeight.normal,
                color: Colors.red.shade900,
                fontFamily: 'Signatra'
              ),
            ),
            Text("Sell, Purchase or Exchange within the\n                 Campus of VCET",
            style: TextStyle(
              fontSize: 17.0,
               fontFamily:'Verela',
              color: Colors.black,
              fontWeight: FontWeight.normal
            ),),
            Image.asset('assets/images/campus.jpg',
            height: size.height * 0.40,),
            SizedBox(height: size.height * 0.01,),
            RoundedButton(
              color: Colors.black54,
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
