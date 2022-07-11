import 'package:flutter/material.dart';

// ******************************************************************************************
// Circular indictor to indicate when there is a call to an api or other asynchronous events
// ******************************************************************************************


class CircularIndicator extends StatelessWidget {
  final String messageToDisplay;

  const CircularIndicator(this.messageToDisplay, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // color: Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Text(messageToDisplay,
              style: const TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color:
                     Colors.black),
              textAlign: TextAlign.center),
        ),
        const CircularProgressIndicator(
          color: 
              Colors.black,
        )
      ])),
    );
  }
}
