// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/ball.dart';
import 'package:myapp/bricks.dart';
import 'package:myapp/cover_screen.dart';
import 'package:myapp/gameover_screen.dart';
import 'package:myapp/player.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Directions
enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //Variables for the ball size
  double ballX = 0;
  double ballY = 0;
  var ballXDirection = direction.DOWN;
  var ballYDirection = direction.LEFT;
  double ballXincreements = 0.01;
  double ballYincreements = 0.01;

  //Variables for the brick
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.05;
  bool brickBroken = false;
  
  //Method to start the game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      checkForBrokenBrick();
    });
  }

  //Method to check the broken brick
  void checkForBrokenBrick() {
    if (ballX >= brickX &&
        ballX <= brickWidth &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
        ballYDirection = direction.DOWN;
      });
    }
  }

  //Method to move the ball
  void moveBall() {
    setState(() {
      if(ballXDirection == direction.LEFT){
        ballX -= ballXincreements;
      } else if(ballXDirection == direction.RIGHT){
        ballX += ballXincreements;
      }
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincreements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincreements;
      }
    });
  }

  //Updating the direction
  void updateDirection() {
    setState(() {
      if(ballX >= 1){
        ballXDirection = direction.LEFT;
      } else if(ballX <= -1){
        ballXDirection = direction.RIGHT;
      }
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }
    });
  }

  //Checking whether the game has started
  bool hasGameStarted = false;
  bool isGameOver = false;
  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    } else {
      return false;
    }
  }

  //Player details
  double playerX = -0.2;
  double playerWidth = 0.4;

  //Moving player to left
  void moveLeft() {
    setState(() {
      if (playerX > -1) {
        playerX -= 0.2;
      }
    });
  }

  //Moving player to the right
  void moveRight() {
    setState(() {
      if (playerX + playerWidth < 1) {
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
                //Game over
                GameoverScreen(isGameOver: isGameOver),
                //Ball
                Ball(ballX: ballX, ballY: ballY),
                //Player
                Player(playerX: playerX, playerWidth: playerWidth),
                //Bricks
                Bricks(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickY: brickY,
                  brickX: brickX,
                  brickBroken: brickBroken,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
