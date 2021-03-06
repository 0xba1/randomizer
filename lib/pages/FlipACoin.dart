import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:randomizer/widgets/BlinkingCircle.dart';

import 'About.dart';
import 'HomePage.dart';
import 'RandomNumber.dart';
import 'RandomPassword.dart';
import 'Sarcasticize.dart';

String flipACoin() {
  Random random = Random.secure();
  bool coinFlip = random.nextBool();

  if (coinFlip) return "HEADS";
  return "TAILS";
}

class CoinNotifier {
  ValueNotifier coin = ValueNotifier("resting");

  void changeValue(newValue) {
    coin.value = newValue;
  }
}

class FlipACoin extends StatefulWidget {
  const FlipACoin({Key key}) : super(key: key);

  @override
  _FlipACoinState createState() => _FlipACoinState();
}

class _FlipACoinState extends State<FlipACoin> {
  CoinNotifier coinNotifier = CoinNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flip A Coin",
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
                child: Text("Pick a Random Number"),
                value: "randomNumber",
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
              } else if (value == "randomNumber") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomNumber()));
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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.replay),
        label: Text(
          "FLIP COIN",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w200),
        ),
        onPressed: () {
          coinNotifier.changeValue("loading");
          Timer(Duration(milliseconds: 2500),
              () => coinNotifier.changeValue(flipACoin()));
        },
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: coinNotifier.coin,
          builder: (BuildContext context, dynamic value, Widget child) {
            if (value == "resting")
              return Container();
            else if (value == "loading")
              return BlinkingCircle(size: 200);
            else
              return Container(
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 20,
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
