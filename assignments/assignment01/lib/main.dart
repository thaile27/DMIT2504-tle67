// ignore_for_file: use_key_in_widget_constructors, todo

import 'package:flutter/material.dart';

//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

//This app makes use of the Row, Column,
//Expanded, Padding, Transform, Container,
//BoxDecoration, BoxShape, Colors,
//Border, Center, Align, Alignment,
//EdgeInsets, Text, and TextStyle Widgets
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //first level widget of Material Design
      home: Scaffold(
        //default route
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text("App1 - UI Layout"),
          backgroundColor: Colors.blue,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //TODO: Put your code here to complete this app.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(color: Colors.black, width: 3)),
                    child: const Center(
                      child: Text("Container 1"),
                    )),
                Transform.rotate(
                  angle: 45,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    child: const Center(
                      child: Text('Container 2'),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(top: 250.0),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Container 3"),
                    )),
                // Container(
                //     width: 100,
                //     padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                //     color: Colors.blue,
                //     child: const Align(
                //       alignment: Alignment.topCenter,
                //       child: Text("Container 4"),
                //     )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
