import 'package:flutter/material.dart';
import 'package:bubbletest_project/vars.dart';

class TopBar extends StatelessWidget {
  final int score;
  final int averageSkill;
  final int flex;

  TopBar(this.score, this.averageSkill, {this.flex = 2});

  @override
  Widget build(BuildContext context) {
    Screen.setSize(MediaQuery.of(context).size);
    return Expanded(
      flex: flex,
      child: Container(
          color: Colors.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("SKILL:",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 3)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(averageSkill.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 3)
                  ],
                )
              ]),
              Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("SCORE:",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 3)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(score.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 3)
                  ],
                )
              ])
            ],
          )),
    );
  }
}
