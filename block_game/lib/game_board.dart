import 'dart:async';
import 'dart:math';

import 'package:block_game/widgets/particle_explosion_effect.dart';
import 'package:block_game/utils/piece.dart';
import 'package:block_game/widgets/pixel.dart';
import 'package:block_game/utils/values.dart';
import 'package:flutter/material.dart';

/*GAME BOARD
This is a 2x2 grid with null representing an empty space.
A non-empty space will have the color to represent the landed pieces*/
// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Current block piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // Current score
  int currentScore = 0;

  // Game over status
  bool gameOver = false;

  // Timer reference
  Timer? gameTimer;

  //GAME SPEED
  double gameSpeed = 800;

  // Explosion flag to show the explosion on line clear
  bool showExplosion = false;
  Offset explosionPosition = Offset(0, 0); // Position of the explosion

  @override
  void initState() {
    super.initState();
    // Start the game when the app starts
    startGame();
    print('Game Speed: $gameSpeed');
  }

  void startGame() {
    currentPiece.initializePiece();

    // Frame refresh rate
    Duration frameRate = Duration(milliseconds: gameSpeed.toInt());
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    gameTimer?.cancel(); // Ensure no duplicate timers
    gameTimer = Timer.periodic(frameRate, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        // Clear lines
        clearLines();

        // Check landing
        if (checkLanding()) {
          timer.cancel(); // STOP the timer when piece lands
          createNewPiece(); // CREATE a new piece
          startGame(); // RESTART the game loop for the new piece
        } else {
          // Move current piece down
          currentPiece.movePiece(Direction.down);
        }

        // Check if the game is over
        if (gameOver) {
          timer.cancel();
          showGameOverDialog(context);
        }
      });
    });
  }

  bool isDialogOpen = false;

  void showGameOverDialog(BuildContext context) {
    if (isDialogOpen) return;
    isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                isDialogOpen = false; // Reset when dialog is closed
                gameSpeed = 800;
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    print("Game Reset Start Ho Raha Hai"); // Debugging Step 3

    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (j) => null),
    );

    currentScore = 0;
    gameOver = false; // Ensure gameOver state is reset

    print("New Game Piece Banaya Ja Raha Hai"); // Debugging Step 4
    Future.delayed(Duration(milliseconds: 300), () {
      createNewPiece();
      startGame();
    });

    print("Game Reset Complete"); // Debugging Step 5
  }

  // Check for collision
  bool checkCollision(Direction direction) {
    for (var i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int column = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        column -= 1;
      } else if (direction == Direction.right) {
        column += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || column < 0 || column >= rowLength) {
        return true;
      }

      if (row >= 0 && gameBoard[row][column] != null) {
        return true;
      }
    }
    return false;
  }

  bool checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && row < colLength && col >= 0 && col < rowLength) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      return true;
    }
    return false;
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // Move left
  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // Rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // Move right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // Clear lines
  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        // Trigger explosion animation
        setState(() {
          showExplosion = true;

          // Get the center of the screen
          double screenCenterX = MediaQuery.of(context).size.width / 2;
          double screenCenterY = MediaQuery.of(context).size.height / 2;

          // Set explosion position to the center of the screen
          explosionPosition = Offset(screenCenterX, screenCenterY);
        });
        // Shift all rows above this one DOWN
        for (int r = row; r > 0; r--) {
          for (int c = 0; c < rowLength; c++) {
            gameBoard[r][c] = gameBoard[r - 1][c]; // Move upper row down
          }
        }
        // Top row should be empty after shift
        for (int c = 0; c < rowLength; c++) {
          gameBoard[0][c] = null;
        }

        currentScore++; // Increase score

        // **Increase speed after clearing a line**
        if (gameSpeed > 100) {
          gameSpeed -= 100; // Speed up by reducing delay
        }

        // Restart game loop with new speed
        gameLoop(Duration(milliseconds: gameSpeed.toInt()));

        // After explosion effect duration, hide the explosion
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            showExplosion = false;
          });
        });
      }
    }
  }

  // Check if the game is over
  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    gameTimer?.cancel(); // Cancel timer on widget dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                // GAME BOARD
                Expanded(
                  child: GridView.builder(
                    itemCount: rowLength * colLength,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength,
                    ),
                    itemBuilder: (context, index) {
                      int row = (index / rowLength).floor();
                      int col = index % rowLength;
                      if (currentPiece.position.contains(index)) {
                        return Pixel(
                          color: currentPiece.color,
                        );
                      } else if (gameBoard[row][col] != null) {
                        final Tetromino? tetrominoType = gameBoard[row][col];
                        return Pixel(
                          color: tetrominoColors[tetrominoType],
                        );
                      } else {
                        return Pixel(
                          color: Colors.grey[900],
                        );
                      }
                    },
                  ),
                ),

                // SCORE
                Text(
                  'Score: ${currentScore.toString()}',
                  style: TextStyle(color: Colors.white),
                ),

                // GAME CONTROLS
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: moveLeft,
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back_ios)),
                      IconButton(
                          onPressed: rotatePiece,
                          color: Colors.white,
                          icon: Icon(Icons.rotate_right)),
                      IconButton(
                          onPressed: moveRight,
                          color: Colors.white,
                          icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
              ],
            ),
            if (showExplosion)
              Align(
                alignment: Alignment.center,
                child: ParticleExplosion(position: explosionPosition),
              ),
          ],
        ),
      ),
    );
  }
}
