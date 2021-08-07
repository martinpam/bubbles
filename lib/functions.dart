import 'dart:math';

import 'package:bubbletest_project/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double getRandomCoordinate({bool isWall = false}) {
  if (!isWall) {
    return Random.secure().nextBool()
        ? Random.secure().nextDouble()
        : -Random.secure().nextDouble();
  } else {
    return Random.secure().nextBool() ? 1 : -1;
  }
}

bool hasReachedTarget(var entry) {
  var x_posCurrent = entry['x_posCurrent'];
  var x_posPrevious = entry['x_posPrevious'];
  var y_posCurrent = entry['y_posCurrent'];
  var y_posPrevious = entry['y_posPrevious'];
  var x_posTarget = entry['x_posTarget'];
  var y_posTarget = entry['y_posTarget'];

  if (x_posTarget == -1) {
    return x_posCurrent == -1;
  }
  if (x_posTarget == 1) {
    return x_posCurrent == 1;
  }
  if (y_posTarget == -1) {
    return y_posCurrent == -1;
  }
  if (y_posTarget == 1) {
    return y_posCurrent == 1;
  }

  return false;
  /* bool xIsEqual = x_posCurrent == x_posPrevious;
  bool yIsEqual = y_posCurrent == y_posPrevious;
  bool xCurrentIsTarget = x_posCurrent == x_posTarget;
  bool yCurrentIsTarget = y_posCurrent == y_posTarget;
  return xIsEqual && yIsEqual && xCurrentIsTarget && yCurrentIsTarget;*/
}

double y_range(double speed, double x_distance, double y_distance) {
  double secondsToReachTarget =
      getSecondsToReachTarget(x_distance, y_distance, speed);
  int intervals = (secondsToReachTarget /
          GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
          1000)
      .toInt();
  double res = y_distance / intervals;
  return res;
}

double x_range(double speed, double x_distance, double y_distance) {
  double secondsToReachTarget =
      getSecondsToReachTarget(x_distance, y_distance, speed);
  int intervals = (secondsToReachTarget /
          GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
          1000)
      .toInt();
  double res = x_distance / intervals;
  return res;
}

getSecondsToReachTarget(double x_distance, double y_distance, double speed) {
  return hypotenuse(
          x_distance / Screen.height / 22 * 20 * Screen.width, y_distance) *
      100 /
      speed;
}

List<double> calculateDistances(var entry) {
  List<double> res = [];
  var x_distance, y_distance;
  //get all variables out of map for slight(?) performance improvement and manipulation
  var x_posSpawn = entry['x_posSpawn'];
  var y_posSpawn = entry['y_posSpawn'];
  var x_posTarget = entry['x_posTarget'];
  var y_posTarget = entry['y_posTarget'];

  x_distance = (x_posSpawn - x_posTarget).abs();
  y_distance = (y_posSpawn - y_posTarget).abs();

  res.addAll({x_distance, y_distance});
  return res;
}

double hypotenuse(double x, double y) {
  return sqrt(pow(x, 2) + pow(y, 2));
}

void setPreviousToCurrent(var entry) {
  entry['x_posPrevious'] = entry['x_posCurrent'];
  entry['y_posPrevious'] = entry['y_posCurrent'];
}

getNewRandomTarget(var entry, var time) {
  bool x_isWall = Random().nextBool();

  entry['x_posTarget'] = x_isWall
      ? entry['x_posTarget'] == -1.0
          ? 1.0
          : entry['x_posTarget'] == 1.0
              ? -1.0
              : getRandomCoordinate(isWall: true)
      : getRandomCoordinate();
  entry['y_posTarget'] = x_isWall
      ? getRandomCoordinate()
      : entry['y_posTarget'] == -1.0
          ? 1.0
          : entry['y_posTarget'] == 1.0
              ? -1.0
              : getRandomCoordinate(isWall: true);
  entry['x_posSpawn'] = entry['x_posCurrent'];
  entry['y_posSpawn'] = entry['y_posCurrent'];
  entry['x_posPrevious'] = GameVariables.OUT_OF_RANGE;
  entry['y_posPrevious'] = GameVariables.OUT_OF_RANGE;
}

void addComponent(
    int nrOfCircles, var components, var timeAtSpawn, int nrOfBombs) {
  for (int i = 0; i < nrOfCircles; i++) {
    double x_posSpawn = getRandomCoordinate();
    double y_posSpawn = getRandomCoordinate();

    bool x_isWall = Random().nextBool();

    double x_posTarget =
        x_isWall ? getRandomCoordinate(isWall: true) : getRandomCoordinate();
    double y_posTarget =
        x_isWall ? getRandomCoordinate() : getRandomCoordinate(isWall: true);
    double x_posCurrent = x_posSpawn;
    double y_posCurrent = y_posSpawn;
    double x_posPrevious = GameVariables.OUT_OF_RANGE;
    double y_posPrevious = GameVariables.OUT_OF_RANGE;

    components.putIfAbsent(
        IDManager.getId(),
        () => {
              'component': Components.Circle,
              'x_posSpawn':
                  x_posSpawn, //at start the spawn is a random position on the screen, later the old target
              'y_posSpawn': y_posSpawn,
              'x_posTarget': x_posTarget,
              'y_posTarget': y_posTarget,
              'x_posCurrent': x_posCurrent,
              'y_posCurrent': y_posCurrent,
              'x_posPrevious':
                  x_posPrevious, //posPrevious helps with identifying halted components in the scene
              'y_posPrevious': y_posPrevious,
              'timeAtSpawn': timeAtSpawn
            });
  }

  for (int i = 0; i < nrOfBombs; i++) {
    double x_posSpawn = getRandomCoordinate();
    double y_posSpawn = getRandomCoordinate();

    bool x_isWall = Random().nextBool();

    double x_posTarget =
        x_isWall ? getRandomCoordinate(isWall: true) : getRandomCoordinate();
    double y_posTarget =
        x_isWall ? getRandomCoordinate() : getRandomCoordinate(isWall: true);
    double x_posCurrent = x_posSpawn;
    double y_posCurrent = y_posSpawn;
    double x_posPrevious = GameVariables.OUT_OF_RANGE;
    double y_posPrevious = GameVariables.OUT_OF_RANGE;

    components.putIfAbsent(
        IDManager.getId(),
        () => {
              'component': Components.Bomb,
              'x_posSpawn':
                  x_posSpawn, //at start the spawn is a random position on the screen, later the old target
              'y_posSpawn': y_posSpawn,
              'x_posTarget': x_posTarget,
              'y_posTarget': y_posTarget,
              'x_posCurrent': x_posCurrent,
              'y_posCurrent': y_posCurrent,
              'x_posPrevious':
                  x_posPrevious, //posPrevious helps with identifying halted components in the scene
              'y_posPrevious': y_posPrevious,
              'timeAtSpawn': timeAtSpawn
            });
  }
}

void updatePositionsNew(
    var entry, List<double> distances, double intensity, double currentTime) {
  final double x_posCurrent = entry['x_posCurrent'];
  final double y_posCurrent = entry['y_posCurrent'];
  final double x_posTarget = entry['x_posTarget'];
  final double y_posTarget = entry['y_posTarget'];
  final double timeAtSpawn = entry['timeAtSpawn'];
  final double x_posSpawn = entry['x_posSpawn'];
  final double y_posSpawn = entry['y_posSpawn'];
  final double x_posNew, y_posNew;

  var _x_range = x_range(intensity, distances[0], distances[1]);
  var _y_range = y_range(intensity, distances[0], distances[1]);

  double _secondsToReachTarget =
      getSecondsToReachTarget(distances[0], distances[1], intensity);

  if (x_posCurrent < (x_posTarget - _x_range) &&
      y_posCurrent < (y_posTarget - _y_range)) {
    x_posNew = x_posSpawn +
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _x_range;
    y_posNew = y_posSpawn +
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _y_range;

    //if the component is on the left upper side of the target
  } else if (x_posCurrent < (x_posTarget - _x_range) &&
      y_posCurrent > (y_posTarget + _y_range)) {
    x_posNew = x_posSpawn +
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _x_range;
    y_posNew = y_posSpawn -
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _y_range;
    //if the component is on the right lower side of the target
  } else if (x_posCurrent > (x_posTarget + _x_range) &&
      y_posCurrent < (y_posTarget - _y_range)) {
    x_posNew = x_posSpawn -
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _x_range;
    y_posNew = y_posSpawn +
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _y_range;
    //if the target is on the right upper side of the component
  } else if (x_posCurrent > (x_posTarget + _x_range) &&
      y_posCurrent > (y_posTarget + _y_range)) {
    x_posNew = x_posSpawn -
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _x_range;
    y_posNew = y_posSpawn -
        (currentTime - timeAtSpawn) *
            1000 /
            GameVariables.REFRESH_INTERVAL_IN_MILLISECONDS *
            _y_range;
  } else if (y_posCurrent > (y_posTarget - _y_range) &&
      y_posCurrent < (y_posTarget - _y_range)) {
    y_posNew = y_posTarget;
    x_posNew = x_posCurrent > (x_posTarget + _x_range)
        ? x_posCurrent - _x_range
        : x_posCurrent < (x_posTarget - _x_range)
            ? x_posCurrent + _x_range
            : x_posCurrent;
  } else if (x_posCurrent > (x_posTarget - _x_range) &&
      x_posCurrent < (x_posTarget - _x_range)) {
    y_posNew = y_posCurrent > (y_posTarget + _y_range)
        ? y_posCurrent - _y_range
        : y_posCurrent < (y_posTarget - _y_range)
            ? y_posCurrent + _y_range
            : y_posCurrent;
    x_posNew = x_posTarget;
    //otherwise the component is near the target, so set it to the targets coordinates
  } else if (currentTime >= timeAtSpawn + _secondsToReachTarget) {
    x_posNew = x_posTarget;
    y_posNew = y_posTarget;
    entry['timeAtSpawn'] = currentTime;
  } else {
    x_posNew = x_posCurrent;
    y_posNew = y_posCurrent;
  }

  entry['x_posCurrent'] = x_posNew;
  entry['y_posCurrent'] = y_posNew;
}

double calculateTimeToClear(
    int nrComponents, double intensity, Map components, int nrBombs) {
  double res = 0;
  components.forEach((key, value) {
    if (value['component'] == Components.Circle) {
      res += ((BASE_CIRCLE_CLEAR_TIME + intensity / 100) /
          getMassComponentsFactor(nrComponents));
    }
    if (value['component'] == Components.Bomb) {
      res += ((BASE_BOMB_CLEAR_TIME + intensity / 100));
    }
    //TO-DO: implement other components
  });

  return res;
}

double getMassComponentsFactor(int nrComponents) {
  if (nrComponents < 2) return 1;
  if (nrComponents < 3) return 1.5;
  if (nrComponents < 4) return 2;
  if (nrComponents < 6) return 3;
  if (nrComponents < 8) return 4;
  if (nrComponents < 10) return 5;
  if (nrComponents < 12) return 6;
  return nrComponents / 2;
}

//TO-DO: adjust acc part
double adjustSkill(averageSkill, timeToClear, roundActualClearTime, accuracy,
    bool bombExploded, Function setBombExplosion) {
  if (bombExploded) {
    setBombExplosion(false);
    return averageSkill - SKILL_PER_LEVEL * 2.0;
  }
  double relativeSuccess = timeToClear / roundActualClearTime;
  return (averageSkill -
      SKILL_PER_LEVEL / 2 +
      min(SKILL_PER_LEVEL * relativeSuccess, SKILL_PER_LEVEL) -
      (0.90 - accuracy) * SKILL_PER_LEVEL);
}

TableRow getTableRow(RoundResult result, int splitFactor,
    {bool useAsHeading = false,
    String h1 = "",
    String h2 = "",
    String h3 = "",
    String h4 = "",
    String h5 = ""}) {
  return TableRow(children: [
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        alignment: Alignment.center,
        height: Screen.height / splitFactor,
        width: 32,
        color: useAsHeading ? Colors.amber : Colors.amberAccent,
        child: !useAsHeading
            ? Text(result.circles.toString(),
                style: TextStyle(fontSize: 18, decorationColor: Colors.black))
            : Image.asset(h1),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        alignment: Alignment.center,
        height: Screen.height / splitFactor,
        width: 32,
        color: useAsHeading ? Colors.amber : Colors.amberAccent,
        child: !useAsHeading
            ? Text(result.bombs.toString(),
                style: TextStyle(fontSize: 18, decorationColor: Colors.black))
            : Image.asset(h2),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
          alignment: Alignment.center,
          height: Screen.height / splitFactor,
          width: 32,
          color: useAsHeading ? Colors.amber : Colors.amberAccent,
          child: !useAsHeading
            ? Text((result.accuracy*100).toStringAsFixed(2),
                style: TextStyle(fontSize: 18, decorationColor: Colors.black))
            : Image.asset(h3),
    ),),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
          alignment: Alignment.center,
          height: Screen.height / splitFactor,
          width: 32,
          color: useAsHeading ? Colors.amber : Colors.amberAccent,
          child: !useAsHeading
            ? Text(result.timeNeeded.toStringAsFixed(2),
                style: TextStyle(fontSize: 18, decorationColor: Colors.black))
            : Image.asset(h4),
    ),),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
          alignment: Alignment.center,
          height: Screen.height / splitFactor,
          width: 32,
          color: useAsHeading ? Colors.amber : Colors.amberAccent,
          child: !useAsHeading
            ? Text(result.pointsEarned.toString(),
                style: TextStyle(fontSize: 18, decorationColor: Colors.black))
            : Image.asset(h5),
    ),),
  ]);
}
