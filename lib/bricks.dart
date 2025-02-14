import 'package:flutter/material.dart';

class Bricks extends StatelessWidget {
  const Bricks({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });
  final double brickHeight;
  final double brickWidth;
  final double brickX;
  final double brickY;
  final bool brickBroken;

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
          alignment: Alignment(brickX, brickY),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: MediaQuery.of(context).size.height * brickHeight / 2,
              width: MediaQuery.of(context).size.width * brickWidth / 2,
              color: Colors.deepPurple,
            ),
          ),
        );
  }
}
