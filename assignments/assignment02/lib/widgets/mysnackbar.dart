// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:robbinlaw/main.dart';

class MySnackBar {
  String text;
  MySnackBar({required this.text});

  void show() {
    //print(scaffoldMessengerKey.currentState);
    scaffoldMessengerKey.currentState?.showSnackBar(get());
  }

  SnackBar get() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.white),
          const SizedBox(
            width: 10,
          ),
          Text(text),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: OutlinedButton(
                onPressed: () {
                  print(text);
                },
                child: const Text(
                  'Sign in',
                )),
          )
        ],
      ),
    );
  }
}
