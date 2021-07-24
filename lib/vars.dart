import 'package:flutter/material.dart';

enum Components {
  Circle,
  Magnet,
  BilliardBall,
  //TO-DO: add more components
}

class Screen {
  static double width = -1;
  static double height = -1;

  static void setSize(Size size) {
    width = size.width;
    height = size.height;
    var a = "";
  }
}

class Movement {
  static double y_range_100 = 0.005;
  static double x_range_100 = y_range_100 / Screen.width * Screen.height;
  static double translateYtoX(double y) {
    return y / Screen.width * Screen.height;
  }
}

class GameVariables {
  static final double OUT_OF_RANGE = -4.5;
  static final int REFRESH_INTERVAL_IN_MILLISECONDS = 5;
  static final bool debugIsOn = true;
}

class IDManager {
  static int _id = 0;
  static int getId() {
    return _id++;
  }
}

class LevelInfo {
  static Map levels = {
    '1': [
      {'stage': 0, 'nrComponents': 1, 'speed': 50, 'totalDifficulty': 0},
      {'stage': 1, 'nrComponents': 2, 'speed': 50, 'totalDifficulty': 100},
      {'stage': 2, 'nrComponents': 2, 'speed': 55, 'totalDifficulty': 110},
      {'stage': 3, 'nrComponents': 2, 'speed': 60, 'totalDifficulty': 120},
      {'stage': 4, 'nrComponents': 2, 'speed': 65, 'totalDifficulty': 130},
      {'stage': 5, 'nrComponents': 3, 'speed': 65, 'totalDifficulty': 195},
      {'stage': 6, 'nrComponents': 3, 'speed': 70, 'totalDifficulty': 210},
      {'stage': 7, 'nrComponents': 3, 'speed': 75, 'totalDifficulty': 225},
      {'stage': 8, 'nrComponents': 3, 'speed': 80, 'totalDifficulty': 240},
      {'stage': 9, 'nrComponents': 4, 'speed': 80, 'totalDifficulty': 320},
      {'stage': 10, 'nrComponents': 4, 'speed': 85, 'totalDifficulty': 340},
      {'stage': 11, 'nrComponents': 4, 'speed': 90, 'totalDifficulty': 360},
      {'stage': 12, 'nrComponents': 4, 'speed': 95, 'totalDifficulty': 380},
      {'stage': 13, 'nrComponents': 5, 'speed': 95, 'totalDifficulty': 475},
      {'stage': 14, 'nrComponents': 5, 'speed': 100, 'totalDifficulty': 500},
      {'stage': 15, 'nrComponents': 5, 'speed': 105, 'totalDifficulty': 525},
      {'stage': 16, 'nrComponents': 5, 'speed': 110, 'totalDifficulty': 550},
    ]
  };
}