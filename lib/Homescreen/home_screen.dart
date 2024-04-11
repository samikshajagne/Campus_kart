import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../ProfileScreen/profile_screen.dart';
import '../SearchProduct/search_product.dart';
import '../UploadAdScreen/upload_ad_screen.dart';
import '../WelcomeScreen/welcome_screen.dart';
import '../Widgets/GlobalVariable.dart';
import '../Widgets/listview_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  getMyData() {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((results) {
      setState(() {
        userImageUrl = results.data()!['userImage'];
        getUserName = results.data()!['userName'];
      });
    });
  }

  getUserAddress() async {
    Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    position = newPosition;
    placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark placemark = placemarks![0];

    String newCompleteAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare},'
        '${placemark.subThoroughfare} ${placemark.locality},'
        '${placemark.subAdministrativeArea}'
        '${placemark.administrativeArea} ${placemark.postalCode},'
        '${placemark.country}';

    completeAddress = newCompleteAddress;
    print(completeAddress);
    return completeAddress;
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
    uid = FirebaseAuth.instance.currentUser!.uid;
    userEmail = FirebaseAuth.instance.currentUser!.email!;
    getMyData();
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
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.search, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.logout, color: Colors.black, size: 25),
              ),
            ),
          ],
          title: const Text(
            "Campus Kart",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Signatra',
              fontSize: 35,
            ),
          ),
          centerTitle: false,
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
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('items').orderBy('time', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return ListViewWidget(

                      docId: snapshot.data!.docs[index].id,
                      itemColor: snapshot.data!.docs[index]['itemColor'],
                      img1: snapshot.data!.docs[index]['urlImage1'],
                      img2: snapshot.data!.docs[index]['urlImage2'],
                      img3: snapshot.data!.docs[index]['urlImage3'],
                      img4: snapshot.data!.docs[index]['urlImage4'],
                      img5: snapshot.data!.docs[index]['urlImage5'],
                      userImg: snapshot.data!.docs[index]['imgPro'],
                      name: snapshot.data!.docs[index]['username'],
                      date: snapshot.data!.docs[index]['time'],
                      userId: snapshot.data!.docs[index]['id'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],
                      snapshot.data!.docs[index]['time'],

                    );
                  },
                );
              } else {
                return Center(child: Text("No items available"));
              }
            } else {
              return Center(child: Text("Connection state: ${snapshot.connectionState}"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Post',
          backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadAdScreen()));
          },
          child: const Icon(Icons.cloud_upload),
        ),
      ),
    );
  }
}
