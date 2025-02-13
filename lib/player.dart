import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({super.key, required this.playerX, required this.playerWidth});

  final playerX;
  final playerWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * playerWidth) / (2 - playerWidth), 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 10,
          width: playerWidth / 2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
