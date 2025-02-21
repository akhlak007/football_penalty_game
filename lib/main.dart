import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PenaltyGame(),
    );
  }
}

class PenaltyGame extends StatefulWidget {
  @override
  _PenaltyGameState createState() => _PenaltyGameState();
}

class _PenaltyGameState extends State<PenaltyGame> {
  double ballX = 0;
  double ballY = 0.8;
  double playerX = 0; // Player can move along X-axis
  double goalkeeperX = 0;
  int score = 0;
  bool isGoal = false;
  bool gameOver = false;

  // Move player left and right
  void movePlayer(bool isLeft) {
    setState(() {
      if (isLeft) {
        playerX = max(playerX - 0.2, -1);
      } else {
        playerX = min(playerX + 0.2, 1);
      }
    });
  }

  // Shoot the ball
  void shootBall() {
    double targetX = playerX; // Shot direction depends on player's position
    double goalkeeperMove = (Random().nextDouble() * 2 - 1); // Random goalkeeper move

    setState(() {
      // Move ball
      ballX = targetX;
      ballY = -1; // Ball goes to the goal line

      // Move goalkeeper
      goalkeeperX = goalkeeperMove;

      // Check if it's a goal
      if ((ballX - goalkeeperX).abs() > 0.2) {
        isGoal = true;
        score++;
      } else {
        isGoal = false;
      }

      gameOver = true;
    });
  }

  // Reset game
  void resetGame() {
    setState(() {
      ballX = 0;
      ballY = 0.8;
      playerX = 0;
      isGoal = false;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Penalty Game'),
      ),
      body: Stack(
        children: [
          // Football field
          Container(
            color: Colors.green[400],
            width: double.infinity,
            height: double.infinity,
          ),

          // Goalpost (using an image)
          Align(
            alignment: Alignment(0, -1),
            child: Image.asset(
              'assets/goalpost.png',
              width: 300,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),

          // Goalkeeper (using an image)
          Align(
            alignment: Alignment(goalkeeperX, -0.8),
            child: Image.asset(
              'assets/goalkeeper2.png',
              width: 80,
              height: 80,
            ),
          ),

          // Player (using an image) that can move


          // Football
          Align(
            alignment: Alignment(ballX, ballY),
            child: Image.asset(
              'assets/football.png',
              width: 30,
              height: 30,
            ),
          ),

          // Game Over Screen
          if (gameOver)
            Center(
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isGoal ? 'Goal!' : 'Saved!',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resetGame,
                      child: Text('Play Again'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => movePlayer(true), // Move player left
            child: Icon(Icons.arrow_left),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: shootBall, // Shoot the ball
            child: Icon(Icons.sports_soccer),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => movePlayer(false), // Move player right
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
