import 'package:campus_cart/Support/support.dart';
import 'package:campus_cart/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../Homescreen/home_screen.dart';
import '../Widgets/GlobalVariable.dart';
import 'package:campus_cart/LoginScreen/login_screen.dart';
import 'package:campus_cart/ProfileScreen/profile_screen.dart';
import 'package:campus_cart/SignupScreen/signup_screen.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildBackButton() {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(sellerId: uid)),
          );
        },
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: buildBackButton(),
          backgroundColor: Colors.cyan.shade900,
          title: const Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Signatra',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        body: ListView(
          children: [
            _buildListItem(
              text: 'Logout',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
            _buildListItem(
              text: 'Sign in to another account',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            _buildListItem(
              text: 'Help & Support',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => support()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({required String text, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: onTap,
        ),
        Container(
          height: 1,
          color: Colors.cyan.shade900,
        ),
      ],
    );
  }
}
