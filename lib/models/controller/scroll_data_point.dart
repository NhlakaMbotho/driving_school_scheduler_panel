import 'package:flutter/rendering.dart';

class ScrollDataPoint {
  final double position;
  final ScrollDirection direction;
  final int controllerId;
  final Axis axis;

  const ScrollDataPoint(this.position, this.direction, this.controllerId, this.axis);

  @override
  String toString() {
    return "position -> $position, direction -> ${direction}";
  }
}
