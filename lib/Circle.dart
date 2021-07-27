import 'package:bubbletest_project/vars.dart';
import 'package:flutter/material.dart';

class MyCircle extends StatelessWidget {
  final double size;
  final entry;
  final Function tapHandler;
  final int id;
  final bool startAnimation;
  final double animationDurationInSeconds;
  MyCircle(
      this.size, this.entry, this.tapHandler, this.id, this.startAnimation, this.animationDurationInSeconds);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapHandler(5, id),
      child: AnimatedContainer(
        duration: Duration(milliseconds: (animationDurationInSeconds * 1000).toInt()),
        alignment: !startAnimation ? Alignment(entry['x_posSpawn'], entry['y_posSpawn']) :Alignment(entry['x_posTarget'], entry['y_posTarget']) ,
        child: Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              
            ),
            child: !GameVariables.debugIsOn ? null : Text(this.id.toString()),
            ),
      ),
    );
  }
}


class TargetSign extends StatelessWidget {
  final double size;
  final entry;
  
  TargetSign(
      this.size, this.entry);

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
        duration: Duration(seconds: 0),
        alignment: Alignment(entry['x_posTarget'], entry['y_posTarget']) ,
        child: Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              
            ),
            
            ),);
      
    
  }
}