// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/ball.dart';
import 'package:myapp/bricks.dart';
import 'package:myapp/cover_screen.dart';
import 'package:myapp/gameover_screen.dart';
import 'package:myapp/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double ballX = 0;
  double ballY = 0;
  Direction ballXDirection = Direction.LEFT;
  Direction ballYDirection = Direction.DOWN;
  final double ballXIncrements = 0.01;
  final double ballYIncrements = 0.01;

  // Brick properties
  static const double brickWidth = 0.5;
  static const double brickHeight = 0.05;
  static const double brickGap = 0.02;
  static const int numberOfBricksInRow = 4;
  static const int numberOfBrickRows = 3;
  static double wallGap =
      0.5 * (2 - numberOfBricksInRow * brickWidth - (numberOfBricksInRow - 1) * brickGap);
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.5; // Adjusted to a more visible position

  List<List<dynamic>> myBricks = [];

  bool hasGameStarted = false;
  bool isGameOver = false;

  double playerX = -0.2;
  final double playerWidth = 0.4;

  @override
  void initState() {
    super.initState();
    generateBricks();
  }

  void generateBricks() {
    myBricks.clear();
    for (var row = 0; row < numberOfBrickRows; row++) {
      for (var col = 0; col < numberOfBricksInRow; col++) {
        final x = firstBrickX + col * (brickWidth + brickGap);
        final y = firstBrickY - row * (brickHeight + brickGap);
        myBricks.add([x, y, false]); // [x, y, isBroken]
      }
    }
  }

  void startGame() {
    if (!hasGameStarted) {
      setState(() {
        hasGameStarted = true;
      });

      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          updateDirection();
          moveBall();
          checkForBrokenBrick();

          if (isPlayerDead()) {
            timer.cancel();
            isGameOver = true;
          }
        });
      });
    }
  }

  void checkForBrokenBrick() {
    for (final brick in myBricks) {
      final brickX = brick[0] as double;
      final brickY = brick[1] as double;
      final isBroken = brick[2] as bool;

      if (!isBroken &&
          ballX >= brickX &&
          ballX <= brickX + brickWidth &&
          ballY >= brickY &&
          ballY <= brickY + brickHeight) {
        setState(() {
          brick[2] = true;
          ballYDirection = Direction.DOWN;
        });
      }
    }
  }

  void moveBall() {
    if (ballXDirection == Direction.LEFT) {
      ballX -= ballXIncrements;
    } else if (ballXDirection == Direction.RIGHT) {
      ballX += ballXIncrements;
    }

    if (ballYDirection == Direction.DOWN) {
      ballY += ballYIncrements;
    } else if (ballYDirection == Direction.UP) {
      ballY -= ballYIncrements;
    }

    if (ballX > 1.0) ballX = 1.0;
    if (ballX < -1.0) ballX = -1.0;
    if (ballY > 1.0) ballY = 1.0;
    if (ballY < -1.0) ballY = -1.0;
  }

  void updateDirection() {
    if (ballX >= 1.0) {
      ballXDirection = Direction.LEFT;
    } else if (ballX <= -1.0) {
      ballXDirection = Direction.RIGHT;
    }

    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = Direction.UP;
    } else if (ballY <= -1.0) {
      ballYDirection = Direction.DOWN;
    }
  }

  bool isPlayerDead() {
    return ballY >= 1.0;
  }

  void moveLeft() {
    setState(() {
      if (playerX > -1) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + playerWidth < 1) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              moveLeft();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              moveRight();
          }
        }
    },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                CoverScreen(hasGameStarted: hasGameStarted),
                GameoverScreen(isGameOver: isGameOver),
                Ball(ballX: ballX, ballY: ballY),
                Player(playerX: playerX, playerWidth: playerWidth),
                for (final brick in myBricks)
                  if (!(brick[2] as bool))
                    Bricks(
                      brickHeight: brickHeight,
                      brickWidth: brickWidth,
                      brickX: brick[0] as double,
                      brickY: brick[1] as double,
                      brickBroken: brick[2] as bool,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
