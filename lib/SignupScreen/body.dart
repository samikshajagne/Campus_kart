import 'dart:io';

import 'package:campus_cart/SignupScreen/signupbackground.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpBody extends StatefulWidget {


  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  File? _image;
  final Signupformkey = GlobalKey<FormState>();

  void _getfromcamera() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropimage(pickedFile?.path);
    Navigator.pop(context);
  }

  void _getfromgallery() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropimage(pickedFile?.path);
    Navigator.pop(context);
  }

  void _cropimage(filePath) async
  {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if(croppedImage != null)
      {
        setState(() {
          _image = File(croppedImage.path);
        });
      }
  }

  void _showImageDialog()
  {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
              onTap: ()
              {
                _getfromcamera();
              },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.all(4.0),
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
                onTap: ()
                {
                  _getfromgallery();
                },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text('Gallery',
                    style: TextStyle(
                      color: Colors.purple,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        );

      }
    );
  }
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
                  _showImageDialog();
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
            ),
            ),
          ],
      ),
    ));
  }
}
