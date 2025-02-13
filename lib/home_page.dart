// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/ball.dart';
import 'package:myapp/cover_screen.dart';
import 'package:myapp/player.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Directions
enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  //Variables for the ball size
  double ballX = 0;
  double ballY = 0;
  var ballDirection = direction.DOWN;

  //Method to start the game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
    });
  }

  //Method to move the ball
  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  //Updating the direction
  void updateDirection() {
    setState(() {
      if (ballY >= 0.9) {
        ballDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = direction.DOWN;
      }
    });
  }

  //Checking whether the game has started
  bool hasGameStarted = false;

  //Player details
  double playerX = 0;
  double playerWidth = 0.2;

  //Moving player to left
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  //Moving player to the right
  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth > -1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                //Tap to Play button
                CoverScreen(hasGameStarted: hasGameStarted),
                //Ball
                Ball(ballX: ballX, ballY: ballY),
                //Player
                Player(playerX: playerX, playerWidth: playerWidth),
                //Location of playerX
                Container(
                  alignment: Alignment(playerX, 0.9),
                  child: Container(color: Colors.red, width: 4, height: 15),
                ),
                Container(
                  alignment: Alignment(playerX + playerWidth, 0.9),
                  child: Container(color: Colors.green, width: 4, height: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
