import 'package:flutter/material.dart';
class GameoverScreen extends StatelessWidget {
  final bool isGameOver;

  const GameoverScreen({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: const Text(
              'GAME OVER!',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 32,
              ),
            ),
          )
        : Container();
  }
}