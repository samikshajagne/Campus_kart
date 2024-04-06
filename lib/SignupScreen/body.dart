import 'dart:io';

import 'package:campus_cart/SignupScreen/signupbackground.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatefulWidget {

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  File? _image;
  final Signupformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width,
           screenheight = MediaQuery.of(context).size.height;
    return SignupBackground(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(key: Signupformkey,
            child: InkWell(
              onTap: (){

              },
              child: CircleAvatar(
                radius: screenwidth * 0.20 ,
                backgroundColor: Colors.white24,
                backgroundImage: _image == null
                ? null : FileImage(_image!),
                child: _image == null
                ? Icon(Icons.camera_enhance,
                        size: screenwidth * 0.18,
                        color: Colors.black54,
                )
                    : null,
              ),
            ),),
          ],
      ),
    ));
  }
}
