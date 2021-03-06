import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Randomizer",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Container(
              child: Text("Version 1.0.0"),
            ),
            Container(
              child: Image.asset(
                '/assets/images/logo-blueback.png',
                width: 100,
                height: 100,
              ),
            ),
            Container(
              child: Text("SimpleTools 2021"),
            ),
          ],
        ),
      ),
    );
  }
}
