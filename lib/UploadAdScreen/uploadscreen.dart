import 'dart:io';
import 'package:campus_cart/DialogBox/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

import '../Homescreen/home_screen.dart';
import '../Widgets/GlobalVariable.dart';

class UploadAdScreen extends StatefulWidget {
  @override
  State<UploadAdScreen> createState() => _UploadAdScreenState();
}

class _UploadAdScreenState extends State<UploadAdScreen> {
  String postId = Uuid().v4();
  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String phoneNo = '';
  CollectionReference? imgRef;
  String itemPrice = '';
  String itemModel = '';
  String itemColor = '';
  String itemDescription = '';

  chooseImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

   uploadFile() async {
    try {
      for (var img in _image) {
        final ref =
        FirebaseStorage.instance.ref().child('images/${Path.basename(img.path)}');
        final uploadTask = ref.putFile(img);
        final storageTaskSnapshot = await uploadTask;

        final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        urlsList.add(downloadUrl);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getNameOfUser() {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then(
          (snapshot) {
        if (snapshot.exists) {
          setState(() {
            name = snapshot.data()!['userName'];
            phoneNo = snapshot.data()!['userNumber'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getNameOfUser();
    imgRef = FirebaseFirestore.instance.collection('imageUrls');
  }

  void addDataToFirestore() {
    FirebaseFirestore.instance.collection('items').doc(postId).set({
      'userName': name,
      'id': _auth.currentUser!.uid,
      'userNumber': phoneNo,
      'itemPrice': itemPrice,
      'itemModel': itemModel,
      'itemColor': itemColor,
      'itemDescription': itemDescription,
      'imageUrls': urlsList,
      'lat': position!.latitude,
      'lng': position!.longitude,
      'address': completeAddress,
      'time': DateTime.now(),
      'status': 'approved',
    }).then((_) {
      print('Data added successfully');
      Fluttertoast.showToast(
        msg: 'Data added successfully...',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }).catchError((error) {
      print('Failed to add data: $error');
      Fluttertoast.showToast(
        msg: 'Failed to add data: $error',
        toastLength: Toast.LENGTH_LONG,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.pinkAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.pinkAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            next ? 'Please write Item Info' : 'Choose Item Images',
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: 'Signatra',
              fontSize: 35,
            ),
          ),
          actions: [
            next
                ? Container()
                : ElevatedButton(
              onPressed: () {
                if (_image.length == 5) {
                  setState(() {
                    uploading = true;
                    next = true;
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: 'Please Select 5 images only..',
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black54,
                  fontFamily: 'Varela',
                ),
              ),
            ),
          ],
        ),
        body: next
            ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Item Price',
                  ),
                  onChanged: (value) {
                    itemPrice = value;
                  },
                ),
                const SizedBox(height: 5.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Item Name',
                  ),
                  onChanged: (value) {
                    itemModel = value;
                  },
                ),
                const SizedBox(height: 5.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Item Color',
                  ),
                  onChanged: (value) {
                    itemColor = value;
                  },
                ),
                const SizedBox(height: 5.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Write some Items Description',
                  ),
                  onChanged: (value) {
                    itemDescription = value;
                  },
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LoadingAlertDialog(
                            message: 'Uploading....',
                          );
                        },
                      );
                      uploadFile().then((_) {
                        addDataToFirestore();
                      });
                    },
                    child: const Text(
                      'upload',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        ImagePicker imagePicker = imagePicker();
                        imagePicker.pickImage(source: ImageSource.gallery);
                      },
                    ),
                  )
                      : Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_image[index - 1]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            uploading
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'uploading...',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  CircularProgressIndicator(
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  ),
                ],
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
