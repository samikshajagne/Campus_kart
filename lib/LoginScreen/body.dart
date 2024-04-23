import 'package:flutter/material.dart';
import 'package:campus_cart/ForgetPassword/forget_password.dart';
import 'package:campus_cart/SignupScreen/signup_screen.dart';
import 'package:campus_cart/Widgets/already_have_account_check.dart';
import 'package:campus_cart/Widgets/rounded_button.dart';
import 'package:campus_cart/Widgets/rounded_input_field.dart';
import 'package:campus_cart/Widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_cart/DialogBox/error_dialog.dart';
import 'package:campus_cart/DialogBox/login_dialog.dart';
import 'package:campus_cart/Homescreen/home_screen.dart';
import 'package:campus_cart/LoginScreen/background.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    showDialog(
      context: context,
      builder: (_) {
        return LoadingAlertDialog(message: 'Please wait......');
      },
    );

    User? currentUser;

    await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(message: error.message.toString());
        },
      );
    });

    if (currentUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1), // Adjust spacing
            Image.asset(
              'assets/images/login1.jpg',
              width: double.infinity, // Adjust width as needed
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              'Campus kart',
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.normal,
                color: Colors.red.shade900,
                fontFamily: 'Signatra',
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: RoundedInputField(
                hintText: 'Email',
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    _emailController.text = value;
                  });
                }, backgroundColor: Colors.white, shadowColor: Colors.black87,
                border: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    _passwordController.text = value;
                  });
                }, backgroundColor: Colors.white, shadowColor: Colors.black87, border:Colors.red,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPassword()),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundedButton(

              text: 'Login',
              press: () {
                _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty
                    ? _login()
                    : showDialog(
                  context: context,
                  builder: (context) {
                    return ErrorAlertDialog(
                        message:
                        'Please write email & password for login ');
                  },
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
