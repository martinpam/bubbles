

import 'package:bubbletest_project/vars.dart';
import 'package:flutter/material.dart';

import 'Circle.dart';
import 'Taptoplay.dart';


class MyStack extends StatelessWidget {
  
  final bool gameHasStarted;
  final Function startTapHandler;
  Map components;
  final Function tapHandler;


  MyStack(this.gameHasStarted,this.startTapHandler,this.components,this.tapHandler);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    components.forEach((key,value) {
      if (value['component'] == Components.Circle) {
        list.add(MyCircle(70.0, value['x_posCurrent'], value['y_posCurrent'], tapHandler,key));

        if (GameVariables.debugIsOn) list.add( MyCircle(10, value['x_posTarget'], value['y_posTarget'], ()=>1+1, -1));
      }
    });
    return gameHasStarted ? Stack(
                children: [
                  Container(color: Colors.blueGrey),
                  ...list,
                ],
              ):TapToPlay(gameHasStarted, startTapHandler);
  }
}