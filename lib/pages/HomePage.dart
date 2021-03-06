import 'package:flutter/material.dart';
import 'package:randomizer/pages/About.dart';
import 'package:randomizer/pages/RandomNumber.dart';
import 'package:randomizer/pages/RandomPassword.dart';
import 'package:randomizer/pages/Sarcasticize.dart';
import 'package:randomizer/widgets/RouteButton.dart';
import 'package:randomizer/pages/FlipACoin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Randomizer"),
        elevation: 0.7,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("About app"),
                value: "about",
              )
            ],
            onSelected: (value) {
              if (value == "about") {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
            RouteButton(
              text: "Random Password",
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomPassword()))
              },
            ),
            Divider(),
            RouteButton(
              text: "Flip a coin",
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FlipACoin()))
              },
            ),
            Divider(),
            RouteButton(
                text: "Pick a Random Number",
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomNumber()))
                    }),
            Divider(),
            RouteButton(
              text: "saRcAStIsiZE wORdS",
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sarcasticize()))
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
