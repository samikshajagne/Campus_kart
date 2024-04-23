import 'package:campus_cart/Widgets/text_feild_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {

  final ValueChanged<String> onChanged;

  RoundedPasswordField({
    required this.onChanged, required Color backgroundColor, required Color shadowColor, required border,
});

  @override
  State<RoundedPasswordField> createState() {
    return _RoundedPasswordFieldState();
  }
}

bool  obsecureText = true;

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
          obscureText: !obsecureText,
          onChanged: widget.onChanged,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: GestureDetector(
              onTap: ()
              {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
              child: Icon(
                obsecureText
                 ? Icons.visibility
                    :Icons.visibility_off,
                color: Colors.black54,
              ),
            ),
            border: InputBorder.none,
          ),
        ) );
  }
}
