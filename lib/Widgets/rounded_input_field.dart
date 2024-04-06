import 'package:campus_cart/Widgets/text_feild_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  RoundedInputField({
    required this.hintText,
    required this.icon, // Changed from iconData to IconData
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.teal,
        decoration: InputDecoration(
          icon: Icon(
            icon, // Changed from Icon to icon
            color: Colors.black,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
