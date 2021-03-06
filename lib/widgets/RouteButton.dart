import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({Key key, this.onPressed, this.text}) : super(key: key);
  final onPressed;
  final text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: SizedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
