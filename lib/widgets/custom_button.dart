import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  CustomButton({this.onPressed, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 50,
      height: 50,
      shape: CircleBorder(),
      color: Colors.blue,
      onPressed: onPressed,
      child: Icon(iconData, color: Colors.white),
    );
  }
}
