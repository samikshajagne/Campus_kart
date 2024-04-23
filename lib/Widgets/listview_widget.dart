import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ListViewWidget extends StatefulWidget {
  final String docId,
      itemColor,
      userImg,
      name,
      userId,
      itemModel,
      postId;
  final String itemPrice, itemDescription, address, userNumber;
  final DateTime date;
  final double lat, lng;

  ListViewWidget({
    required this.docId,
    required this.itemColor,
    required this.userImg,
    required this.name,
    required this.date,
    required this.userId,
    required this.itemModel,
    required this.postId,
    required this.itemPrice,
    required this.itemDescription,
    required this.lat,
    required this.lng,
    required this.address,
    required this.userNumber,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Future<void> showDialogForUpdateData(
      String selectDoc,
      String oldUserName,
      String oldPhoneNumber,
      String oldItemPrice,
      String oldItemName,
      String oldItemColor,
      String oldItemDescription,
      ) async {
    TextEditingController userNameController =
    TextEditingController(text: oldUserName);
    TextEditingController phoneNumberController =
    TextEditingController(text: oldPhoneNumber);
    TextEditingController itemPriceController =
    TextEditingController(text: oldItemPrice);
    TextEditingController itemNameController =
    TextEditingController(text: oldItemName);
    TextEditingController itemColorController =
    TextEditingController(text: oldItemColor);
    TextEditingController itemDescriptionController =
    TextEditingController(text: oldItemDescription);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Data',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Bebas',
              letterSpacing: 2.0,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextFormField('Enter Your Name', userNameController),
                buildTextFormField(
                    'Enter Your Phone Number', phoneNumberController),
                buildTextFormField('Enter Your Item Price', itemPriceController),
                buildTextFormField('Enter Your Item Name', itemNameController),
                buildTextFormField('Enter Item Color', itemColorController),
                buildTextFormField('Write Description', itemDescriptionController),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                updateProfileNameOnExistingPosts(userNameController.text);
                _updateUserName(
                  userNameController.text,
                  phoneNumberController.text,
                );

                FirebaseFirestore.instance
                    .collection('item')
                    .doc(selectDoc)
                    .update({
                  'userName': userNameController.text,
                  'userNumber': phoneNumberController.text,
                  'userItem': itemPriceController.text,
                  'itemModel': itemNameController.text,
                  'itemColor': itemColorController.text,
                  'itemdescription': itemDescriptionController.text,
                }).then((value) {
                  Fluttertoast.showToast(
                    msg: 'The Task has been uploaded',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.grey,
                    fontSize: 18.0,
                  );
                }).catchError((onError) {
                  print(onError);
                });
              },
              child: Text('Update Now'),
            ),
          ],
        );
      },
    );
  }

  void updateProfileNameOnExistingPosts(String oldUserName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    querySnapshot.docs.forEach((doc) {
      String userProfileNameInPost = doc['userName'];

      if (userProfileNameInPost != oldUserName) {
        FirebaseFirestore.instance.collection('item').doc(doc.id).update({
          'userName': oldUserName,
        });
      }
    });
  }

  Future<void> _updateUserName(
      String oldUserName, String oldPhoneNumber) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'userName': oldUserName,
      'userNumber': oldPhoneNumber,
    });
  }

  TextFormField buildTextFormField(
      String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 16.0,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemModel,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM, YYYY - hh:mm a')
                            .format(widget.date)
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  trailing: widget.userId != FirebaseAuth.instance.currentUser!.uid
                      ? SizedBox()
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialogForUpdateData(
                            widget.docId,
                            widget.name,
                            widget.userNumber,
                            widget.itemPrice,
                            widget.itemModel,
                            widget.itemColor,
                            widget.itemDescription,
                          );
                        },
                        icon: Icon(
                          Icons.edit_note,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(widget.postId)
                              .delete()
                              .then((value) {
                            Fluttertoast.showToast(
                              msg: 'Post Has Been Deleted',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.grey,
                              fontSize: 18.0,
                            );
                          }).catchError((error) {
                            print(error);
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          size: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
