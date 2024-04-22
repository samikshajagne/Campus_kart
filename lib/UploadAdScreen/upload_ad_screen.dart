import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../Homescreen/home_screen.dart';
import '../Widgets/GlobalVariable.dart';

class UploadAdScreen extends StatefulWidget {
  @override
  State<UploadAdScreen> createState() => _UploadAdScreenState();
}

class _UploadAdScreenState extends State<UploadAdScreen> {
  String postId = Uuid().v4();
  bool next = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String phoneNo = '';
  CollectionReference? imgRef;
  String itemPrice = '';
  String itemModel = '';
  String itemColor = '';
  String itemDescription = '';

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
          title: const Text(
            'Please write Item Info',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'Signatra',
              fontSize: 35,
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                    onPressed: addDataToFirestore,
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
        ),
      ),
    );
  }
}
