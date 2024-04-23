import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userchatcard extends StatefulWidget {
  const userchatcard({super.key});

  @override
  State<userchatcard> createState() => _userchatcardState();
}

class _userchatcardState extends State<userchatcard> {
  @override
  Widget build(BuildContext context) {
    Size screenwidth = MediaQuery.of(context).size;
    Size screenheight = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: screenwidth.width * .04,
      vertical: 5),
      color: Colors.red.shade100,
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(child: Icon(CupertinoIcons.person),),
          title: Text('Samiksha'),
          subtitle: Text('last user message',maxLines: 1,),
          trailing: Text('12:00 PM'),
        ),
      ),
    );
  }
}
