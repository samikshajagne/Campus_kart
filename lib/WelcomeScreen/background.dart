import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {

  final Widget child;

  const WelcomeBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(

      ),
      width: double.infinity,
      height: size.height,
      child: Stack(
      alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left:0,
            child: Image.asset('assets/images/main_top.png',
              color: Colors.orangeAccent,
              width: size.width *0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.25, // Adjust this height as needed
              color: Colors.deepOrangeAccent[100],
            ),
          ),

      child,
        ],

      ),
    );
  }
}
