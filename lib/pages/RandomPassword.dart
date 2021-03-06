import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomizer/models/characters.dart';
import 'package:randomizer/widgets/NumericStepFormField.dart';

import 'About.dart';
import 'FlipACoin.dart';
import 'HomePage.dart';
import 'RandomNumber.dart';
import 'Sarcasticize.dart';

class StateNotifier {
  ValueNotifier state = ValueNotifier("resting");
  String statePassword = "";

  void changeState(String newState) {
    state.value = newState;
  }

  void newPassword(String password) {
    statePassword = password;
  }
}

class RandomPassword extends StatefulWidget {
  RandomPassword({Key key}) : super(key: key);

  @override
  _RandomPasswordState createState() => _RandomPasswordState();
}

class _RandomPasswordState extends State<RandomPassword> {
  StateNotifier stateNotifier = StateNotifier();
  bool numbers = true;
  bool lowercase = false;
  bool uppercase = false;
  bool symbols = false;
  bool underscore = false;
  int passwordlength = 4;

  int noOfTrue() {
    // Number of parameters (numbers, lowercase, etc.) that are true.
    int no = 0;

    if (numbers) no++;
    if (lowercase) no++;
    if (uppercase) no++;
    if (symbols) no++;
    if (underscore) no++;

    return no;
  }

  String password() {
    String output = "";

    bool check(List listA, List listB) {
      //Checks if any element of listA is in B
      for (var i = 0; i < listA.length; i++) {
        if (listB.contains(listA[i])) return true;
      }
      return false;
    }

    List tray = [];
    List passwordTray = [];

    Random random = Random.secure();

    if (numbers) tray += numbersList;
    if (lowercase) tray += lowercaseList;
    if (uppercase) tray += uppercaseList;
    if (symbols) tray += symbolsList;
    if (underscore) tray += underscoreList;

    List createSampleFromTray(tempTray, passLength) {
      List tempPasswordTray = [];
      for (var i = 0; i < passLength; i++) {
        tempPasswordTray.add(tempTray[random.nextInt(tempTray.length)]);
      }

      if (numbers && !check(numbersList, tempPasswordTray))
        return createSampleFromTray(tempTray, passLength);

      if (lowercase && !check(lowercaseList, tempPasswordTray))
        return createSampleFromTray(tempTray, passLength);

      if (uppercase && !check(uppercaseList, tempPasswordTray))
        return createSampleFromTray(tempTray, passLength);

      if (symbols && !check(symbolsList, tempPasswordTray))
        return createSampleFromTray(tempTray, passLength);

      if (underscore && !check(underscoreList, tempPasswordTray))
        return createSampleFromTray(tempTray, passLength);

      return tempPasswordTray;
    }

    passwordTray = createSampleFromTray(tray, passwordlength);
    output = passwordTray.join("");

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Password"),
        elevation: 0.7,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Home"),
                value: "home",
              ),
              PopupMenuItem(
                child: Text("Flip A Coin"),
                value: "flipACoin",
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
              } else if (value == "flipACoin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FlipACoin()));
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Numbers"),
              value: numbers,
              onChanged: (newValue) {
                if (noOfTrue() == passwordlength && newValue) return;
                setState(() {
                  numbers = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Lowercase"),
              value: lowercase,
              onChanged: (newValue) {
                if (noOfTrue() == passwordlength && newValue) return;
                setState(() {
                  lowercase = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Uppercase"),
              value: uppercase,
              onChanged: (newValue) {
                if (noOfTrue() == passwordlength && newValue) return;
                setState(() {
                  uppercase = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Symbols"),
              value: symbols,
              onChanged: (newValue) {
                if (noOfTrue() == passwordlength && newValue) return;
                setState(() {
                  symbols = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Underscore"),
              value: underscore,
              onChanged: (newValue) {
                if (noOfTrue() == passwordlength && newValue) return;
                setState(() {
                  underscore = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            NumericStepFormField(
              onChange: (newValue) {
                if (noOfTrue() > newValue) return;
                setState(() {
                  passwordlength = newValue;
                });
              },
              initValue: 4,
              minValue: max(noOfTrue(), 4),
            ),
            Container(
              child: ValueListenableBuilder(
                  valueListenable: stateNotifier.state,
                  builder: (context, value, child) {
                    if (value == "resting") return Container();
                    if (value == "loading")
                      return Container(
                          width: double.infinity,
                          height: 100,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: CircularProgressIndicator()));
                    return Container(
                        width: double.infinity,
                        height: 100,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SelectableText(
                            "${stateNotifier.statePassword}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w200,
                                fontSize: 32),
                          ),
                        )));
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (noOfTrue() == 0) return;
            stateNotifier.changeState("loading");
            stateNotifier.newPassword(password());
            Timer(Duration(milliseconds: 1500), () {
              stateNotifier.changeState("done");
            });
          },
          label: Text("Get Password")),
    );
  }
}
