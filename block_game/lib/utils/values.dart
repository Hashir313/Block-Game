import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

enum Direction {
  left,
  right,
  down,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), // Orange
  Tetromino.J: Color.fromARGB(255, 0, 102, 255), // Blue
  Tetromino.I: Color.fromARGB(255, 242, 0, 255), // Pink
  Tetromino.O: Color(0xFFFFFF00), // Yellow
  Tetromino.S: Color(0xFF008000), // Green
  Tetromino.Z: Color(0xFFFF0000), // Red
  Tetromino.T: Color.fromARGB(255, 144, 0, 255), // Purple
};

enum GameTheme { space, wooden, classic } // Wooden theme added

Map<GameTheme, Map<String, String>> themeBackgrounds = {
  GameTheme.space: {
    'background':
        'assets/images/classic_background.jpg', // Space background image path
  },
  GameTheme.wooden: {
    'background':
        'assets/images/space_background.jpg', // Wooden texture background image path
  },
  GameTheme.classic: {
    'background':
        'assets/images/wooden_texture_block.jpg', // Classic background image path
  },
};
