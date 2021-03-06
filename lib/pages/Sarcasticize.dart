import 'dart:math';

import 'package:flutter/material.dart';

import 'About.dart';
import 'FlipACoin.dart';
import 'HomePage.dart';
import 'RandomNumber.dart';
import 'RandomPassword.dart';

class Sarcasticize extends StatefulWidget {
  const Sarcasticize({Key key}) : super(key: key);

  @override
  _SarcasticizeState createState() => _SarcasticizeState();
}

class _SarcasticizeState extends State<Sarcasticize> {
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  String sarcasticize(String input) {
    String output = "";
    Random random = Random();

    for (var i = 0; i < input.length; i++) {
      String letter = input[i];

      if (random.nextDouble() < 0.45) letter = letter.toUpperCase();

      output += letter;
    }

    return output;
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: Text("saRcAStIsiZE wORdS"),
        elevation: 0.7,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Home"),
                value: "home",
              ),
              PopupMenuItem(
                child: Text("Random Password"),
                value: "randomPassword",
              ),
              PopupMenuItem(
                child: Text("Pick a Random Number"),
                value: "randomNumber",
              ),
              PopupMenuItem(
                child: Text("Flip A Coin"),
                value: "flipACoin",
              ),
              PopupMenuItem(
                child: Text("About app"),
                value: "about",
              ),
            ],
            onSelected: (value) {
              if (value == "home") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else if (value == "randomPassword") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomPassword()));
              } else if (value == "randomNumber") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomNumber()));
              } else if (value == "flipACoin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FlipACoin()));
              } else if (value == "about") {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Input:",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextField(
                    maxLines: null,
                    controller: inputController,
                    onChanged: (String value) {
                      setState(() {
                        outputController.text = sarcasticize(value);
                      });
                      return;
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Output:",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextField(
                    maxLines: null,
                    controller: outputController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
