// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App2'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Replace this Text Widget
              // and build the label and switch here
              // as children of the row.
              Text(
                'Enable Button',
              ),
              Switch(
                value: enabled,
                onChanged: (bool value) {
                  setState(() {
                    enabled = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here
              // as children of the row.
              // For each button use a
              // "Visibility Widget" and its child
              // will be an "ElevatedButton"

              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15.0),
                  ),
                  onPressed: enabled
                      ? () {
                          setState(() {
                            timesClicked++;
                            msg1 = 'Clicked $timesClicked';
                          });
                        }
                      : null,
                  child: Text(timesClicked == 0 ? 'Click Me' : msg1),
                ),
              ),
              SizedBox(width: 10),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15.0),
                  ),
                  onPressed: enabled
                      ? () {
                          setState(() {
                            timesClicked = 0;
                          });
                        }
                      : null,
                  child: Text('Reset'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                  TextFormField(
                    controller: textEditingController,
                    validator: (input) {
                      // The ! tells the compiler that input could
                      // be null, and not to throw an error.
                      return input!.isNotEmpty && input.length < 20
                          ? null
                          : "first name must be 1-20 characters";
                    },
                    onSaved: (input) {
                      // The onSaved event will only be triggered
                      // when the elevated button is pressed and both
                      // TextFormFields are valid.
                      firstName = input;
                    },
                    maxLength: 20,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.hourglass_top),
                      labelText: 'first name',
                      helperText: 'min 1, max 20',
                      suffixIcon: Icon(Icons.check_circle),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(15.0),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          msg1 = 'Hi There, Your name is $firstName';
                          MySnackBar(text: msg1).show();
                          setState(() {});
                        }
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
