import 'package:campus_cart/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget {

  final String message;
  LoadingAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text('Please Wait......')
        ],
      ),
    );
  }
}
