import 'dart:math';
import 'package:bubbletest_project/vars.dart';

double getRandomCoordinate({bool isWall = false}) {
  if (!isWall) {
    return Random().nextBool()
        ? Random().nextDouble()
        : -Random().nextDouble();
  } else {
    return Random().nextBool() ? 1 : -1;
  }
}

getSecondsToReachTarget(double x_distance, double y_distance, double speed) {
  double height = Screen.getHeight();
  double width = Screen.getWidth();
  var x_distance_new = x_distance/height/22*20;
  var x_distance_new_new = x_distance_new * width;

  
  var res = hypotenuse(x_distance_new_new, y_distance) * 100 / speed;
  return res;
}

List<double> calculateDistances(double x_posSpawn, double y_posSpawn, double x_posTarget, double y_posTarget) {
  List<double> res = [];
  var x_distance, y_distance;
  //get all variables out of map for slight(?) performance improvement and manipulation


  x_distance = (x_posSpawn - x_posTarget).abs();
  y_distance = (y_posSpawn - y_posTarget).abs();

  res.addAll({x_distance, y_distance});
  return res;
}

double hypotenuse(double x, double y) {
  
  var res =  sqrt(pow(x, 2) + pow(y, 2));
  return res;
}


getNewRandomTarget(var entry, speed) {
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

            
}





void addComponent(int nrOfComponents, var components, double timeAtSpawn, double speed) {
 
   double x_posSpawn,y_posSpawn,x_posTarget,y_posTarget;
   bool x_isWall;
  for (int i = 0; i < nrOfComponents; i++) {
    x_posSpawn = getRandomCoordinate();
     y_posSpawn = getRandomCoordinate();

     x_isWall = Random().nextBool();

     x_posTarget =
        x_isWall ? getRandomCoordinate(isWall: true) : getRandomCoordinate();
     y_posTarget =
        x_isWall ? getRandomCoordinate() : getRandomCoordinate(isWall: true);

    var distances = calculateDistances(x_posSpawn,y_posSpawn,x_posTarget,y_posTarget);
    double secondsToReachTarget = getSecondsToReachTarget(distances[0], distances[1], speed);

    components.putIfAbsent(
        IDManager.getId(),
        () => {
              'component': Components.Circle,
              'x_posSpawn':
                  x_posSpawn, //at start the spawn is a random position on the screen, later the old target
              'y_posSpawn': y_posSpawn,
              'x_posTarget': x_posTarget,
              'y_posTarget': y_posTarget,
              'timeAtSpawn': timeAtSpawn,
              'startAnimation' : false,
              'animationDuration' : secondsToReachTarget
              
              
                
            });
            
  }
}

