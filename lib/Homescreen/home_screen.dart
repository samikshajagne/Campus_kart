import 'package:campus_cart/chatscreen/chatscreen.dart';
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
        color: Colors.white
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(
                      sellerId: uid,
                    )));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.search, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => chatscreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.chat_bubble_rounded, color: Colors.white),
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

            ),
          ),
          backgroundColor: Colors.red.shade900
          ,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('items').orderBy('time', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(

                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doc = snapshot.data!.docs[index];
                    var docData = doc.data() as Map<String, dynamic>;
                    return ListViewWidget(
                      docId: doc.id,
                      itemColor: docData['itemColor'] ?? '',
                      // Handle missing 'imgPro' field
                      userImg: docData['imgPro'] ?? '',
                      name: docData['username'] ?? '',
                      // Convert 'time' from Timestamp to DateTime
                      date: docData['time'].toDate(),
                      userId: docData['id'] ?? '',
                      address: docData['address'] ?? '',
                      itemDescription: docData['itemDescription'] ?? '',
                      itemModel: docData['itemModel'] ?? '',
                      itemPrice: docData['itemPrice'] ?? '',
                      lat: docData['lat'] ?? 0.0,
                      lng: docData['lng'] ?? 0.0,
                      postId: docData['postId'] ?? '',
                      userNumber: docData['userNumber'] ?? '',
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