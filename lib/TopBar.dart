import 'package:flutter/material.dart';


class TopBar extends StatelessWidget {
  final double accuracy;
  final int averageSkill;
  final int flex;

  TopBar(this.accuracy, this.averageSkill, {this.flex = 2});

  @override
  Widget build(BuildContext context) {

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
                    Text("ACCURACY:",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 3)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(accuracy.isNaN ? "0 %" : accuracy.toStringAsFixed(0)+" %",
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