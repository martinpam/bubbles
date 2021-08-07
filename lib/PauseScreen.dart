import 'package:bubbletest_project/functions.dart';
import 'package:flutter/material.dart';
import 'vars.dart';

class PauseScreen extends StatelessWidget {
  final List<RoundResult> last10Games;
  final Function handleTap;
  final int heightSplitFactor = 14;
  final Color backgroundColor = Colors.blueGrey;
  PauseScreen(this.last10Games, this.handleTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: Screen.height / heightSplitFactor*2,
            color: backgroundColor,
            child: Text(
                  "Your last 10 rounds statistic",
                  style: TextStyle(fontSize: 25, decorationColor: Colors.black),
                )),
        
        
        Table(
            
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(60),
              1: FixedColumnWidth(60),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              getTableRow(last10Games[0], heightSplitFactor,
                  useAsHeading: true,
                  h1: "images/progression.png",
                  h2: "images/progression.png",
                  h3: "images/progression.png",
                  h4: "images/progression.png",
                  h5: "images/progression.png"),
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
            color: Colors.amber,
            child: TextButton(
                onPressed: () => handleTap(),
                child: Text(
                  "Play",
                  style: TextStyle(fontSize: 25, decorationColor: Colors.black),
                ))),
      ],
    );
  }
}
