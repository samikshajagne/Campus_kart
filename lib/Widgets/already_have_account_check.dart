import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {

  final bool login;
  final VoidCallback press;

  AlreadyHaveAnAccountCheck({
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Do not have an Account?': 'Already have an account?',
          style: const TextStyle(color: Colors.black87, fontStyle: FontStyle.italic,),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ?  'Sign Up. ' : 'Sign In. ',
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ],
    );
  }
}
