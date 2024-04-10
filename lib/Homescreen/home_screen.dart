
import 'package:flutter/material.dart';

import '../Widgets/GlobalVariable.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class StatefulWidget {
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  getMyData()
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((results){
          setState(() {
            userImageUrl = results.data()!['userImage'];
            getUserName = results.data()!['userName'];
          });
    });
  }
  getUserAddress() async
  {
    Position newPosition = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    position = newPosition;
    placemarks = await placemarkFromCoordinates
      (position !.latitude,position !. longitude,
    );
    Placemark placemark = placemarks![0];

    String newCompleteAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare},'
        '${placemark.subThoroughfare} ${placemark.locality},'
        '${placemark.subAdministrativeArea}'
        '${placemark.administrativeArea} ${placemark.postalCode},'
        '${placemark.country}';

     completeAddress= newCompleteAddress;
     print(completeAddress);
     return completeAddress ;


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserAddress();
    uid = FirebaseAuth.instance.currentUser!.uid;
    userEmail =FirebaseAuth.instance.currentUser!.email!;
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
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon (Icons.person, color : Colors.black,),
            ),
          ),
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchProduct()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon (Icons.search, color : Colors.black,),
              ),
            ),
      TextButton(
        onPressed: (){
          _auth.signOut().then((value){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=> WelcomeScreen()));
          });

        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon (Icons.logout, color: Colors.black, size: 25,),
        ),
      ),

  ],
          title: const Text("Campus Kart",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Signatra',
          fontSize: 35,
        ),),
          centerTitle: false,

          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.pinkAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                )
            ),
          ),
          ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('items')
              .orderBy('time', descending: true)
              .snapshots(),
            builder: (context, AsyncSnapshot snapshot)
            {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator(),);
              }
              else if (snapshot.connectionState == ConnectionState.active)
              {
                if(snapshot.data.docs.isNotEmpty)
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index)
                      {
                        return ListViewWidget()
                        Widget
                      },

                  );
                }
              }
            },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Post',
          backgroundColor: Colors.black54,
          onPressed: (){
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> UploadAdScreen()));
          },
          child: const Icon(Icons.cloud_upload),
        ),
      ),
    );
  }
}