import 'package:campus_cart/ForgetPassword/forget_password.dart';
import 'package:campus_cart/LoginScreen/background.dart';
import 'package:campus_cart/SignupScreen/signup_screen.dart';
import 'package:campus_cart/Widgets/already_have_account_check.dart';
import 'package:campus_cart/Widgets/rounded_button.dart';
import 'package:campus_cart/Widgets/rounded_input_field.dart';
import 'package:campus_cart/Widgets/rounded_password_field.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.04,),
            Image.asset(
              'assets/icons/login.png',
              height: size.height * 0.32,
            ),
            SizedBox(height: size.height * 0.03,),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.person,
              onChanged: (value) {
                // Set the value of email controller
                setState(() {
                  _emailController.text = value;
                });
              },
            ),
            const SizedBox(height: 3), // Added SizedBox for spacing
            RoundedPasswordField(
              onChanged: (value) {
                // Set the value of password controller
                setState(() {
                  _passwordController.text = value;
                });
              },
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                }, child: const Center(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              ),
            ),
            const SizedBox(height: 8,),
            RoundedButton(text: 'Login', press:(){

            }),
            SizedBox(height: size.height * 0.03,),

            AlreadyHaveAnAccountCheck(
              login: true,
              press: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) => SignupScreen()));
              },
            ),

          ],
        ),
      ),
    );
  }
}
