import 'package:block_game/game_board.dart';
import 'package:block_game/utils/values.dart';
import 'package:flutter/material.dart';

class Piece {
  //type of block pieces
  Tetromino type;

  Piece({required this.type});

  //the piece is just the list of integers
  List<int> position = [];

  //color of block pieces
  Color get color {
    return tetrominoColors[type] ?? Color(0xFFFFFFFF);
  }

  //generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
    }
  }

  //moving piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece() {
    // new position
    List<int> newPosition = [];

    // rotate the piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            // check that this new position is a valid move before assigning it
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // check that this new position is a valid move before assigning it
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.O:
        //No Rotation
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check that this new position is a valid move before assigning it
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + 1,
              position[1] + rowLength + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            // check that this new position is a valid move before assigning it
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;

              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
// get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;
// if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

// otherwise position is valid so return true
    else {
      return true;
    }
  }

// check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
// return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }
// get the col of position
      int col = pos % rowLength;
// check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }

// if there is a piece in the first col and last col, it is going through the wall
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
