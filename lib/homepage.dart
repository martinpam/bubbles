import 'dart:async';
import 'dart:math';
import 'package:bubbletest_project/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:bubbletest_project/vars.dart';
import 'package:bubbletest_project/functions.dart';
import 'Stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool gameHasStarted = false;
  int level = 1;
  int stage = 0;
  int averageSkill = 50;
  double time = 0;
  // double timeSinceLastAdd = 0;

  int currentScore = 0;
  int highScore = 0;
  double speed = 50;
  static var components = Map();
 



  void removeComponent(int points, int id) {
    setState(() {
      components.remove(id);
      

      currentScore += points;
    });
  }

  void resetGame() {
    gameHasStarted = false;
    time = 0;
    stage = 1;
  }

  void startGame() {
    if (!gameHasStarted) {
      gameHasStarted = true;

      if (components.isEmpty) {
        //add random Components depending on current difficulty
        addComponent(
            LevelInfo.levels.entries.elementAt(level - 1).value[stage]
                ['nrComponents'],
            components,
            time, speed);
        stage++;
       
      }

      //below code is executed every 5 ms
      Timer.periodic(
          Duration(
              milliseconds: GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS),
          (timer) {
        time += GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS / 1000;

        components.forEach((key, value) {
          setState(() {
             //start the animation if the component has reached its target
          if (value['startAnimation'] == false && time >= (value['timeAtSpawn']+0.025)) {
            value['startAnimation'] = true;
          } 
          if (time >= (value['timeAtSpawn'] + value['animationDuration'])) {
            value['x_posSpawn'] = value['x_posTarget'];
            value['y_posSpawn'] = value['y_posTarget'];
            getNewRandomTarget(value, speed);
            value['timeAtSpawn'] = time;
            var distances = calculateDistances(value['x_posSpawn'],value['y_posSpawn'],value['x_posTarget'],value['y_posTarget']);
           double secondsToReachTarget = getSecondsToReachTarget(distances[0], distances[1], speed);
           value['animationDuration'] = secondsToReachTarget;  
           
          }
          });
        });

         if (components.isEmpty) {
          addComponent(
              LevelInfo.levels.entries.elementAt(level - 1).value[stage]
                  ['nrComponents'],
              components,
              time,speed);
          speed = LevelInfo.levels.entries.elementAt(level - 1).value[stage]
              ['speed'];
          stage++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(currentScore, averageSkill),
          Expanded(
            flex: 20,
            child: Container(
              child: MyStack(
                  gameHasStarted, startGame, components, removeComponent),
            ),
          ),
        ],
      ),
    );
  }
}
