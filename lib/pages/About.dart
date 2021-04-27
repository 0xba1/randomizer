import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Randomizer",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 32,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Container(
                child: Image(
                  image: AssetImage("assets/images/logo-transback.png"),
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                child: Text("SimpleTools ©2021"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
