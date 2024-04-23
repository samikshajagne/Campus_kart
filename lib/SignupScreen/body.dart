import 'dart:io';

import 'package:campus_cart/ForgetPassword/forget_password.dart';
import 'package:campus_cart/Homescreen/home_screen.dart';
import 'package:campus_cart/LoginScreen/login_screen.dart';
import 'package:campus_cart/SignupScreen/signupbackground.dart';
import 'package:campus_cart/Widgets/already_have_account_check.dart';
import 'package:campus_cart/Widgets/rounded_button.dart';
import 'package:campus_cart/Widgets/rounded_input_field.dart';
import 'package:campus_cart/Widgets/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatefulWidget {
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final Signupformkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloading = true;

  void submitFormOnSignUp() async {
    final isValid = Signupformkey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isloading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final uid = user!.uid;

        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userName': _nameController.text.trim(),
          'id': uid,
          'userNumber': _phoneController.text.trim(),
          'userEmail': _emailController.text.trim(),
          'time': DateTime.now(),
          'status': 'approved',
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (error) {
        setState(() {
          _isloading = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  googlesignup(){
    
  }

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    return SignupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Campus kart',
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.normal,
                color: Colors.red.shade900,
                fontFamily: 'Signatra',
              ),
            ),
           Image.asset('assets/images/avatar.png',
           height: 150,),
            SizedBox(height: screenheight * 0.02),
            RoundedInputField(
              hintText: 'Name',
              icon: Icons.person,
              onChanged: (value) {
                _nameController.text = value;
              },
              backgroundColor: Colors.black,
              shadowColor: Colors.black, border: Colors.red,
            ),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.mail_outline,
              onChanged: (value) {
                _emailController.text = value;
              },
              backgroundColor: Colors.black,
              shadowColor: Colors.black, border: Colors.red,
            ),
            RoundedInputField(
              hintText: 'Phone number',
              icon: Icons.phone,
              onChanged: (value) {
                _phoneController.text = value;
              },
              backgroundColor: Colors.black,
              shadowColor: Colors.black, border: Colors.red,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _passwordController.text = value;
              },
              backgroundColor: Colors.black,
              shadowColor: Colors.black, border: Colors.red,
              
            ) ,
            SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            _isloading
                ? RoundedButton(


              text: 'Sign Up',
              press: () {
                submitFormOnSignUp();
              },
            )
                : Center(
              child: Container(
                width: 70,
                height: 72,
                child: CircularProgressIndicator(),
              ),
            ),
            Positioned(child: RoundedButton(
              text: 'Sign Up with Google',
              color: Colors.red, press: () {  },
            )),
            SizedBox(height: screenheight * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
