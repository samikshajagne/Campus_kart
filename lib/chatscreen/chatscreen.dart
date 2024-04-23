import 'dart:developer';

import 'package:campus_cart/ProfileScreen/profile_screen.dart';
import 'package:campus_cart/Widgets/userchatcard.dart';
import 'package:flutter/material.dart';

import '../Apis/apis.dart';
import '../Homescreen/home_screen.dart';
import '../Widgets/GlobalVariable.dart';

class chatscreen extends StatefulWidget {

  @override
  State<chatscreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<chatscreen> {
  // Dummy data for demonstration

  List<Chat> _chats = [
    Chat(userName: 'User 1', lastMessage: 'Hello!'),
    Chat(userName: 'User 2', lastMessage: 'Hi there!'),
    Chat(userName: 'User 3', lastMessage: 'Hey!'),
    // Add more chat data as needed
  ];

  get list => null;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(sellerId: uid)));
            },
            icon: Icon(Icons.person),
          color: Colors.white,),
          actions: [
            IconButton(onPressed: (){},
              icon:Icon(Icons.search),
              color: Colors.white,)
          ],
          centerTitle: true,
          title: Text('Chats',style: TextStyle(
            color: Colors.white,
            fontFamily: 'Signatra',
            fontSize: 35
          ),),
          backgroundColor: Colors.red.shade900,
        ),
        body: StreamBuilder(
          stream: APIs.firestore.collection('chats').snapshots(),

          builder:(context,snapshot) {
            return ListView.builder(
                itemCount: 16,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return userchatcard();
                }
            );
          }
          )
      )
    );
  }

  _buildBackButton(
      ) {
    return IconButton(
      icon: const Icon(Icons.arrow_back,
        color: Colors.white,),
      onPressed: ()
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      },
    );
  }
}

class Chat {
  final String userName;
  final String lastMessage;

  Chat({required this.userName, required this.lastMessage});
}
