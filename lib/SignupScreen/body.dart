import 'dart:io';

import 'package:campus_cart/DialogBox/error_dialog.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/GlobalVariable.dart';

class SignUpBody extends StatefulWidget {
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  String userPhotoUrl = '';
  File? _image;
  bool _isloading = true;
  final Signupformkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _getfromcamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropimage(pickedFile?.path);
    Navigator.pop(context);
  }

  void _getfromgallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropimage(pickedFile?.path);
    Navigator.pop(context);
  }

  void _cropimage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        _image = File(croppedImage.path);
      });
    }
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getfromcamera();
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.purple,
                      ),
                    ),
                    Text('Camera')
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getfromgallery();
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void submitFormOnSignUp() async {
    final isValid = Signupformkey.currentState!.validate();
    if (isValid) {
      if (_image != null) {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(
              message: 'Please pick an image',
            );
          },
        );
        return;
      }
      setState(() {
        _isloading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        final User? user = _auth.currentUser;
        uid = user!.uid;

        final ref = FirebaseStorage.instance.ref().child('userimages').child(uid + '.jpg');
        await ref.putFile(_image!);
        userPhotoUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userName': _nameController.text.trim(),
          'id': uid,
          'userNumber': _phoneController.text.trim(),
          'userEmail': _emailController.text.trim(),
          'userImage': userPhotoUrl,
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
            return ErrorAlertDialog(
              message: error.toString(),
            );
          },
        );
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width, screenheight = MediaQuery.of(context).size.height;
    return SignupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: Signupformkey,
              child: InkWell(
                onTap: () {
                  _showImageDialog();
                },
                child: CircleAvatar(
                  radius: screenwidth * 0.20,
                  backgroundColor: Colors.white24,
                  backgroundImage: _image == null ? null : FileImage(_image!),
                  child: _image == null
                      ? Icon(
                    Icons.camera_enhance,
                    size: screenwidth * 0.18,
                    color: Colors.black54,
                  )
                      : null,
                ),
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            RoundedInputField(
              hintText: 'Name',
              icon: Icons.person,
              onChanged: (value) {
                _nameController.text = value;
              },
            ),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.mail_outline,
              onChanged: (value) {
                _emailController.text = value;
              },
            ),
            RoundedInputField(
              hintText: 'Phone number',
              icon: Icons.phone,
              onChanged: (value) {
                _phoneController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _passwordController.text = value;
              },
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
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
