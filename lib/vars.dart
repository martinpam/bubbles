import 'package:flutter/material.dart';

enum Components {
  Circle,
  Magnet,
  BilliardBall,
  Bomb,
  //TO-DO: add more components
}



class Screen {
   static double width = 0;
   static double height = 0;

    static void setSize(Size size) {
    width = size.width;
    height = size.height;
    var a = "";
  }

  static double getWidth() {return width;}
  static double getHeight() {return height;}
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
  static final bool debugIsOn = false;
}

class IDManager {
  static int _id = 1;
  static int getId() {
    return _id++;
  }
}

class LevelInfo {
  static Map levels = {
    '1': [
      {'stage': 0, 'nrComponents': 1, 'speed': 50.0, 'totalDifficulty': 0},
      {'stage': 1, 'nrComponents': 2, 'speed': 50.0, 'totalDifficulty': 100},
      {'stage': 2, 'nrComponents': 2, 'speed': 55.0, 'totalDifficulty': 110},
      {'stage': 3, 'nrComponents': 2, 'speed': 60.0, 'totalDifficulty': 120},
      {'stage': 4, 'nrComponents': 2, 'speed': 65.0, 'totalDifficulty': 130},
      {'stage': 5, 'nrComponents': 3, 'speed': 65.0, 'totalDifficulty': 195},
      {'stage': 6, 'nrComponents': 3, 'speed': 70.0, 'totalDifficulty': 210},
      {'stage': 7, 'nrComponents': 3, 'speed': 75.0, 'totalDifficulty': 225},
      {'stage': 8, 'nrComponents': 3, 'speed': 80.0, 'totalDifficulty': 240},
      {'stage': 9, 'nrComponents': 4, 'speed': 80.0, 'totalDifficulty': 320},
      {'stage': 10, 'nrComponents': 4, 'speed': 85.0, 'totalDifficulty': 340},
      {'stage': 11, 'nrComponents': 4, 'speed': 90.0, 'totalDifficulty': 360},
      {'stage': 12, 'nrComponents': 4, 'speed': 95.0, 'totalDifficulty': 380},
      {'stage': 13, 'nrComponents': 5, 'speed': 95.0, 'totalDifficulty': 475},
      {'stage': 14, 'nrComponents': 5, 'speed': 100.0, 'totalDifficulty': 500},
      {'stage': 15, 'nrComponents': 5, 'speed': 105.0, 'totalDifficulty': 525},
      {'stage': 16, 'nrComponents': 5, 'speed': 110.0, 'totalDifficulty': 550},
    ]
  };

  static int getNrComponentsBySkill(int skill, double challengeFactor) {
      
      if (skill < SKILL_PER_CIRCLE*(1+0)) return BASE_NR_COMPONENTS_CIRCLE;
      if (skill < SKILL_PER_CIRCLE*(1+1)) return BASE_NR_COMPONENTS_CIRCLE+1;
      if (skill < SKILL_PER_CIRCLE*(1+2)) return BASE_NR_COMPONENTS_CIRCLE+2;
      if (skill < SKILL_PER_CIRCLE*(1+3)) return BASE_NR_COMPONENTS_CIRCLE+3;
      if (skill < SKILL_PER_CIRCLE*(1+4)) return BASE_NR_COMPONENTS_CIRCLE+4;
      if (skill < SKILL_PER_CIRCLE*(1+5+0.7*1)) return BASE_NR_COMPONENTS_CIRCLE+5;
      if (skill < SKILL_PER_CIRCLE*(1+6+0.7*2)) return BASE_NR_COMPONENTS_CIRCLE+6;
      if (skill < SKILL_PER_CIRCLE*(1+7+0.7*3)) return BASE_NR_COMPONENTS_CIRCLE+7;
      if (skill < SKILL_PER_CIRCLE*(1+5+0.7*6)) return BASE_NR_COMPONENTS_CIRCLE+8;
      if (skill < SKILL_PER_CIRCLE*(1+6+0.7*9)) return BASE_NR_COMPONENTS_CIRCLE+9;
      return 10; 
  }
  static double getSpeedBySkill(int skill, double challengeFactor, int nrComponents) {  
    double newSpeed = BASE_SPEED_COMPONENTS;
    for (int i = 0; i < skill; i++){
      if (i < 100) {newSpeed+=1/3;}
      else if (i < 200) {newSpeed+=1/5;}
      else if (i < 300) {newSpeed+=1/8;}
      else if (i < 400) {newSpeed+=1/10;}
      else if (i < 500) {newSpeed+=1/12;}
      else if (i < 600) {newSpeed+=1/14;}
      else if (i < 800) {newSpeed+=1/20;}
    }
    return newSpeed;
  }

  static int getNrBombsBySkill(int skill, double challengeFactor) {
    return BASE_NR_COMPONENTS_BOMB + ((skill)/ SKILL_PER_BOMB).floor();
  }
}

final double BASE_CIRCLE_CLEAR_TIME = 0.65;
final int SKILL_PER_LEVEL = 25;
final int BASE_NR_COMPONENTS_CIRCLE = 1;
final double BASE_SPEED_COMPONENTS = 30;
final int SKILL_PER_CIRCLE = 55;
final int SKILL_PER_BOMB = 150;
final int BASE_NR_COMPONENTS_BOMB =0;
final double BASE_BOMB_CLEAR_TIME = 0.5;

class RoundResult{
  int circles;
  int bombs;
  double accuracy;
  int pointsEarned;
  double timeNeeded;

  RoundResult(this.circles,this.bombs,this.accuracy,this.pointsEarned,this.timeNeeded);
}


