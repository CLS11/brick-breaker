import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoverScreen extends StatelessWidget {
  bool hasGameStarted;
  CoverScreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
          alignment: Alignment(0, -0.2),
          child: Text(
            'Tap to play',
            style: TextStyle(
              color: Colors.deepPurple[400],
            ),
          ),
        );
  }
}
