import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {

  final Widget child;
  LoginBackground ({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
       color: Colors.white
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/images/main_bottom.png',
              color: Colors.redAccent,
              width: size.width * 0.2,),
          ),
          child,
        ],
      ),
    );
  }
}
