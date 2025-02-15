import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double playerX;
  final double playerWidth;

  const Player({super.key, required this.playerX, required this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX * 2, 0.9),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 10,
          width: MediaQuery.of(context).size.width * playerWidth / 2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
