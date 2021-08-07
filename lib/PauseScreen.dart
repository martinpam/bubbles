import 'package:bubbletest_project/functions.dart';
import 'package:flutter/material.dart';
import 'vars.dart';

class PauseScreen extends StatelessWidget {
  final List<RoundResult> last10Games;
  final Function handleTap;
  final int heightSplitFactor = 14;
  final Color backgroundColor = Colors.black;
  PauseScreen(this.last10Games, this.handleTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.bottomCenter,
            height: Screen.height / heightSplitFactor,
            color: backgroundColor,
            child: Text(
                  "10 Round Statistic",
                  style: TextStyle(fontSize: 25, color: Colors.amber),
                )),
        
        
        Table(
            
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              getTableRow(last10Games[0], heightSplitFactor,
                  useAsHeading: true,
                  h1: "images/circle.png",
                  h2: "images/bullseye.png",
                  h3: "images/stopwatch.png",
                  h4: "images/progression.png",
                  h5: "images/laurel-crown.png"),
              getTableRow(last10Games[0], heightSplitFactor),
              getTableRow(last10Games[1], heightSplitFactor),
              getTableRow(last10Games[2], heightSplitFactor),
              getTableRow(last10Games[3], heightSplitFactor),
              getTableRow(last10Games[4], heightSplitFactor),
              getTableRow(last10Games[5], heightSplitFactor),
              getTableRow(last10Games[6], heightSplitFactor),
              getTableRow(last10Games[7], heightSplitFactor),
              getTableRow(last10Games[8], heightSplitFactor),
              getTableRow(last10Games[9], heightSplitFactor),
            ]),
        Container(
            alignment: Alignment.center,
            height: Screen.height / heightSplitFactor,
            color: backgroundColor,
            child: TextButton(
                onPressed: () => handleTap(),
                style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 30)),
                child: Text("PLAY ON", style: TextStyle(color: Colors.amber),))),
                Container(
            alignment: Alignment.center,
            height: Screen.height / heightSplitFactor,
            color: Colors.grey,
            child: Text(
                  "Advertisement",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )),
      ],
    );
  }
}
