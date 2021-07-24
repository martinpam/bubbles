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
  int intensity = 100;
  static var _components = Map();

  void removeComponent(int points, int id) {
    setState(() {
      _components.remove(id);

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

      if (_components.isEmpty) {
        //add random Components depending on current difficulty
        addComponent(
            LevelInfo.levels.entries.elementAt(level - 1).value[stage]
                ['nrComponents'],
            _components,
            time);

        stage++;
      }

      //below code is executed every 5 ms
      Timer.periodic(
          Duration(
              milliseconds: GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS),
          (timer) {
        time += GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS / 1000;

        //for all components on the screen...
        _components.forEach((key, value) {
          //...check if component reached its target, if not, move towards target
          if (!hasReachedTarget(value)) {
            setState(() {
              setPreviousToCurrent(value);

              updatePositionsNew(
                  value, calculateDistances(value), intensity, time);
            });
          } else {
            //else generate new random target

            setState(() {
              getNewRandomTarget(value, time);
            });
          }
        });

        if (_components.isEmpty) {
          addComponent(
              LevelInfo.levels.entries.elementAt(level - 1).value[stage]
                  ['nrComponents'],
              _components,
              time);
          intensity = LevelInfo.levels.entries.elementAt(level - 1).value[stage]
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
                  gameHasStarted, startGame, _components, removeComponent),
            ),
          ),
        ],
      ),
    );
  }
}
