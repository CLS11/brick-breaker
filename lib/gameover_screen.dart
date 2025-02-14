import 'package:flutter/material.dart';

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key, required this.isGameOver});

  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
          alignment: const Alignment(0, -0.3),
          child: const Text(
            'GAME OVER!', 
            style: TextStyle(
              color: Colors.deepPurple,
              ),
            ),
        )
        : Container();
  }
}
