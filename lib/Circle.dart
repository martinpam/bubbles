import 'package:bubbletest_project/vars.dart';
import 'package:flutter/material.dart';

class MyCircle extends StatelessWidget {
  final double size;
  final double alignment_X;
  final double alignment_Y;
  final Function tapHandler;
  final int id;
  MyCircle(
      this.size, this.alignment_X, this.alignment_Y, this.tapHandler, this.id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapHandler(5, id),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 0),
        alignment: Alignment(alignment_X, alignment_Y),
        child: Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              
            ),
            child: !GameVariables.debugIsOn ? null : Text("\n x: " + this.alignment_X.toStringAsFixed(4) + " \n y: " + this.alignment_Y.toStringAsFixed(4)),
            ),
      ),
    );
  }
}
