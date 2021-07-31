import 'package:bubbletest_project/Bomb.dart';
import 'package:bubbletest_project/vars.dart';
import 'package:flutter/material.dart';

import 'Circle.dart';
import 'Taptoplay.dart';

class MyStack extends StatelessWidget {
  final bool gameHasStarted;
  final Function startTapHandler;
  Map components;
  final Function tapHandler;
  final Function increaseClicks;
  bool pressable;
  final Function setPressable;
  final Function handleBombTap;

  MyStack(
      this.gameHasStarted,
      this.startTapHandler,
      this.components,
      this.tapHandler,
      this.increaseClicks,
      this.pressable,
      this.setPressable,
      this.handleBombTap);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    components.forEach((key, value) {
      if (value['component'] == Components.Circle) {
        list.add(MyCircle(70.0, value['x_posCurrent'], value['y_posCurrent'],
            tapHandler, key, increaseClicks));
      } else if (value['component'] == Components.Bomb) {
        list.add(MyBomb(60.0, value['x_posCurrent'], value['y_posCurrent'], key,
            handleBombTap));
      }
      if (GameVariables.debugIsOn) {
        list.add(MyCircle(10, value['x_posTarget'], value['y_posTarget'],
            () => 1 + 1, -1, () {}));
      }
    });
    return gameHasStarted
        ? GestureDetector(
            onTap: handleTap,
            onTapUp: setPressable(true),
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                Container(color: Colors.blueGrey),
                ...list,
              ],
            ),
          )
        : TapToPlay(gameHasStarted, startTapHandler);
  }

  void handleTap() {
    if (pressable) {
      setPressable(false);
      increaseClicks();
    }
  }
}
