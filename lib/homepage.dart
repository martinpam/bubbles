import 'dart:async';
import 'dart:math';
import 'package:bubbletest_project/PauseScreen.dart';
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
  int averageSkill = 0;

  double time = 0;
  double roundStartTime = 0;
  bool gameIsPaused = false;

  int currentScore = 0;
  double speed = 50;
  double timeToClear = -1;
  int totalClicks = 0;
  int totalClicksOnValidCircles = 0;
  int clicksThisRound = 0;
  int clicksOnValidCirclesThisRound = 0;

  int nrComponents = 0;
  int nrBombs = 0;

  bool pressable = true;
  bool bombWasTriggered = false;
  List<RoundResult> last10Games = [];

  static var _components = Map();

  void removeComponent(int points, int id) {
    if (!gameIsPaused) {
      setState(() {
        _components.remove(id);

        // currentScore += points;

        totalClicksOnValidCircles++;
        clicksOnValidCirclesThisRound++;
      });
    }
  }

  void resetGame() {
    gameHasStarted = false;
    time = 0;
    stage = 1;
  }

  void startGame() {
    if (!gameHasStarted) {
      gameHasStarted = true;

      if (_components.isEmpty || _components.length == nrBombs) {
        _components.clear();
        nrComponents = LevelInfo.getNrComponentsBySkill(averageSkill, 1.1);
        nrBombs = LevelInfo.getNrBombsBySkill(averageSkill, 1.1);
        addComponent(nrComponents, _components, time, nrBombs);
        speed = LevelInfo.getSpeedBySkill(averageSkill, 1.1, nrComponents);
        timeToClear =
            calculateTimeToClear(nrComponents, speed, _components, nrBombs);
        roundStartTime = time;
      }

      //below code is executed every 5 ms
      Timer.periodic(
          Duration(
              milliseconds: GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS),
          (timer) {
        if (!gameIsPaused) {
          time += GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS / 1000;

          //for all components on the screen...
          _components.forEach((key, value) {
            //...check if component reached its target, if not, move towards target
            if (!hasReachedTarget(value)) {
              setState(() {
                setPreviousToCurrent(value);

                updatePositionsNew(
                    value, calculateDistances(value), speed, time);
              });
            } else {
              //else generate new random target

              setState(() {
                getNewRandomTarget(value, time);
              });
            }
          });

          if (_components.isEmpty || _components.length == nrBombs) {
            _components.clear();
            double roundActualClearTime = time - roundStartTime;
            int oldAverageSkill = averageSkill;
            averageSkill = adjustSkill(
                    averageSkill,
                    timeToClear,
                    roundActualClearTime,
                    clicksOnValidCirclesThisRound / clicksThisRound,
                    bombWasTriggered,
                    setBombExplosion)
                .toInt();

            //make sure skill doesnt go below 0    
            averageSkill = averageSkill >= 0 ? averageSkill : 0;

            //add RoundResult
            last10Games.add(new RoundResult(
                nrComponents+nrBombs,
                clicksOnValidCirclesThisRound / clicksThisRound,
                averageSkill - oldAverageSkill,
                roundActualClearTime,
                averageSkill));
            if (last10Games.length == 10) {
              gameIsPaused = true;
            }

            if (!gameIsPaused) {
              nrComponents =
                  LevelInfo.getNrComponentsBySkill(averageSkill, 1.1);
              nrBombs = LevelInfo.getNrBombsBySkill(averageSkill, 1.1);

              addComponent(nrComponents, _components, time, nrBombs);
              speed =
                  LevelInfo.getSpeedBySkill(averageSkill, 1.1, nrComponents);
              timeToClear = calculateTimeToClear(
                  nrComponents, speed, _components, nrBombs);
              roundStartTime = time;
              setState(() {
                clicksThisRound = 0;
                clicksOnValidCirclesThisRound = 0;
              });
            }
          }
        }
      });
    }
  }

  void increaseClicks() {
    if (!gameIsPaused) {
      totalClicks++;
      clicksThisRound++;
    }
  }

  void setPressable(bool setTo) {
    pressable = setTo;
  }

  void setBombExplosion(bool exploded) {
    if (!gameIsPaused) {
      setState(() {
        bombWasTriggered = exploded;
        if (exploded) {
          _components.clear();
        }
      });
    }
  }

  void unpause() {
    if (gameIsPaused) {
      setState(() {
       gameIsPaused = false;
      last10Games.clear();
    });
    }
    
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gameIsPaused ? PauseScreen(last10Games, unpause) : Column(
        children: [
          TopBar(clicksOnValidCirclesThisRound / clicksThisRound * 100,
              averageSkill),
          Expanded(
            flex: 20,
            child: Container(
              child: MyStack(
                  gameHasStarted,
                  startGame,
                  _components,
                  removeComponent,
                  increaseClicks,
                  pressable,
                  setPressable,
                  setBombExplosion, gameIsPaused),
            ),
          ),
        Container(
            alignment: Alignment.center,
            height: Screen.height / 14,
            color: Colors.grey,
            child: Text(
                  "Advertisement",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )),],
        
      ),
    );
  }
}
