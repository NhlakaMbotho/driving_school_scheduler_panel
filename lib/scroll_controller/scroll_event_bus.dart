import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/widgets.dart';

class ScrollEventBus with ChangeNotifier {
  final EventBus _scrollEventBus = EventBus();
  ScrollEventBus();

  void syncController(ScrollController controller, Axis axis) {
    controller.addListener(() {
      _scrollEventBus.fire(ScrollDataPoint(
        controller.offset,
        controller.position.userScrollDirection,
        controller.hashCode,
        axis,
      ));
    });

    _scrollEventBus.on<ScrollDataPoint>().listen((dataPoint) {
      if (dataPoint.axis == axis &&
          dataPoint.controllerId != controller.hashCode &&
          controller.position.pixels != dataPoint.position) {
        controller.jumpTo(dataPoint.position);
      }
    });
  }
}
