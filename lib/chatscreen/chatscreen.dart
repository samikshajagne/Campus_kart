import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
        ),
        body: ListView.builder(
          itemCount: _chats.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_chats[index].userName),
              subtitle: Text(_chats[index].lastMessage),
              // Add onTap handler to navigate to chat screen
              onTap: () {
                // Implement navigation to chat screen
              },
            );
          },
        ),
      ),
    );
  }
}

class Chat {
  final String userName;
  final String lastMessage;

  Chat({required this.userName, required this.lastMessage});
}
