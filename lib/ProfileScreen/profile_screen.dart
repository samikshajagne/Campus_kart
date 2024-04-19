import 'package:campus_cart/UploadAdScreen/upload_ad_screen.dart';
import 'package:campus_cart/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // Add functionality for the first button
                },
                icon: Icon(Icons.edit),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadAdScreen()),
                  );
                },
                child: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()))// Add functionality for the third button
               ; },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Profile Screen'),
          elevation: 0, // Remove elevation
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Colors.blue, // Add thin blue bottom line
              height: 1.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Add functionality for the settings button
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: Center(),
      ),
    );
  }
}
