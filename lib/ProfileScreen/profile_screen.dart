import 'package:campus_cart/Homescreen/home_screen.dart';
import 'package:campus_cart/ProfileScreen/profile_edit.dart';
import 'package:campus_cart/Settings/settings.dart';
import 'package:campus_cart/Widgets/GlobalVariable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/listview_widget.dart';

class ProfileScreen extends StatefulWidget {
  String sellerId;
  ProfileScreen({required this.sellerId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _buildBackButton(){
    return
      Container(
        child: IconButton(
          icon: const Icon(Icons.arrow_back,
          color: Colors.white,),
            onPressed: ()
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        },
        ),

      );

  }

  getResult()
  {
    FirebaseFirestore.instance
        .collection('Items')
        .where('id',isEqualTo: widget.sellerId)
        .where('status',isEqualTo: 'approves')
        .get().then((results)
    {
      setState(() {
        items = results;
        adUserName = items!.docs[0]
        .get('UserName');
      });
    }
    );
  }
  QuerySnapshot? items;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.white],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
    ),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 5,
            shadowColor: Colors.black,
            backgroundColor: Colors.red.shade900,
            leading: _buildBackButton(),
            title:
            const Text("Profile",
            style: TextStyle(
            color: Colors.white,
            fontFamily: 'Signatra',
            fontSize: 35,
            fontWeight: FontWeight.normal
        ),
        ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => profile_edit(
                      )));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => settings(
                      )));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.settings, color: Colors.white),
                ),
              ),
            ],
        ),
          body: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('items')
                  .where('id', isEqualTo : FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('time', descending: true)
                  .snapshots(),
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
            ),]
          ),
        ),
      ),
    );
  }
}
