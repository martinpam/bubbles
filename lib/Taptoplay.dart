import 'package:flutter/material.dart';

class TapToPlay extends StatelessWidget {
 
  final bool gameHasStarted;
  final Function tapHandler;

  TapToPlay(this.gameHasStarted, this.tapHandler);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>tapHandler(),
      child: Container(
                        color: Colors.blueGrey,
                        alignment: Alignment(0, -0.3),
                        child: Text(gameHasStarted ? "" : "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 20, color: Colors.black)),
                      ),
    );
  }
}