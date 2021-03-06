import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomizer/widgets/NumericStepFormField.dart';

import 'About.dart';
import 'FlipACoin.dart';
import 'HomePage.dart';
import 'RandomPassword.dart';
import 'Sarcasticize.dart';

class StateNotifier {
  ValueNotifier state = ValueNotifier("resting");
  int from = 0;
  int to = 0;

  void changeFrom(int newNumber) {
    from = newNumber;
  }

  void changeTo(int newNumber) {
    to = newNumber;
  }

  void changeState(String newState) {
    state.value = newState;
  }

  int randomize() {
    Random random = Random.secure();
    if (to == from) return to;
    if (to > from) return from + random.nextInt(to - from + 1);
    return to + random.nextInt(from - to);
  }
}

class RandomNumber extends StatefulWidget {
  const RandomNumber({Key key}) : super(key: key);

  @override
  _RandomNumberState createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  StateNotifier stateNotifier = StateNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick a Random Number",
        ),
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
                child: Text("Flip A Coin"),
                value: "flipACoin",
              ),
              PopupMenuItem(
                child: Text("saRcAStIsiZE wORdS"),
                value: "sarcasticize",
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
              } else if (value == "flipACoin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FlipACoin()));
              } else if (value == "sarcasticize") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sarcasticize()));
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
          children: [
            Center(
              child: Container(
                width: 300,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("From: "),
                        NumericStepFormField(
                          onChange: (int value) {
                            stateNotifier.changeFrom(value);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("To:      "),
                        NumericStepFormField(
                          onChange: (int value) {
                            stateNotifier.changeTo(value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.symmetric(vertical: 144, horizontal: 5),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: stateNotifier.state,
                  builder: (context, value, child) {
                    if (value == "resting") return Container();
                    if (value == "loading") return CircularProgressIndicator();
                    int random = stateNotifier.randomize();
                    return Text(
                      "$random",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 32,
                        fontWeight: FontWeight.w200,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          stateNotifier.changeState("loading");
          Timer(Duration(milliseconds: 1000),
              () => stateNotifier.changeState("done"));
        },
        label: Text("Randomize"),
        icon: Icon(Icons.motion_photos_on),
      ),
    );
  }
}
