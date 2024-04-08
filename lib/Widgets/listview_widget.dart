
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewWidget extends StatefulWidget {
  String docId, itemColor, img1, img2, img3, img4, img5,userImg, name , userId, itemModel, postId;
  String itemPrice, itemdescription, address, userNumber;
  DateTime date;
  double lat,lng;

  ListViewWidget({
    required this.docId,
    required this.itemColor,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.userImg,
    required this.name,
    required this.date,
    required this.userId,
    required this.itemModel,
    required this.postId,
    required this.itemPrice,
    required this.itemdescription,
    required this.lat,
    required this.lng,
    required this.address,
    required this.userNumber,

});
  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {

  Future<Future> showDialogForUpdateData(selectDoc, oldUserName, oldPhoneNumber, oldItemPrice, oldItemColor , oldItemDescription) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder:(BuildContext context)
        {
          return SingleChildScrollView(
              child: AlertDialog(
                title: Text('Update Data',style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Bebas',
                  letterSpacing: 2.0,

                ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: oldUserName,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Name',
                      ),
                      onChanged: (value){
                        setState((){
                          oldUserName = value;
                        });
                      },
                    ),
                    SizedBox(height: 5.0,),
                    TextFormField(
                      initialValue: oldPhoneNumber,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your PhoneNumber',
                      ),
                      onChanged: (value){
                        setState((){
                          oldPhoneNumber = value;
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 16.0,
      shadowColor: Colors.white10,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.pinkAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            )
        ),
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: ()
              {
                //For image slider screen
              },
              child: Image.network(
                widget.img1,
                fit: BoxFit.cover,
              ),
            ),
           const SizedBox(height:8.0),
            Padding(
              padding: const EdgeInsets.only(left : 8.0,right: 8.0,bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      widget.userImg,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0,),
                      Text(
                        widget.itemModel,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0,),
                      Text(
                        DateFormat('dd MMM, YYYY - hh :mm a').format(widget.date).toString(),
                        style:const TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 5.0,),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
    );
  }
}
