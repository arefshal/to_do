import 'package:flutter/material.dart';

class Bottome extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  Bottome({
    Key? key, // Add the Key parameter
    required this.text,
    required this.onPressed,
  }) : super(key: key); // Use super(key: key) to pass the key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow,
      child: Text(text),
    );
  }
}
