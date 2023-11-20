import 'package:driving_school_scheduler_panel/models/data_point.dart';
import 'package:flutter/material.dart';

double _leftSideBarRatio = .13;
double _rightSideBarRatio = .04;
double _topPanelHeightRatio = .05;
double _bottomPanelHeightRatio = .05;
double _cardSeparatorHeight = 10;

class SchedulerSetup {
  /// for max horizontal span
  final int maxHourCount;
  final int startHour;

  /// for max vertical span
  final List<DataPoint> dataPoints;

  final Size blockSize;

  const SchedulerSetup({
    required this.startHour,
    required this.maxHourCount,
    required this.dataPoints,
    required this.blockSize,
  });
}

class SchedulerData extends InheritedWidget {
  final SchedulerSetup setup;

  final BoxConstraints constraints;

  const SchedulerData({required this.setup, required this.constraints, super.key, required super.child});

  double get leftPanelWidth => constraints.maxWidth * _leftSideBarRatio;

  double get rightPanelWidth => constraints.maxWidth * _rightSideBarRatio;

  double get innerWidth => constraints.maxWidth - (leftPanelWidth + rightPanelWidth);

  double get topPanelHeight => constraints.maxHeight * _topPanelHeightRatio;

  double get bottomPanelHeight => constraints.maxHeight * _bottomPanelHeightRatio;

  double get innerHeight => constraints.maxHeight - (topPanelHeight + bottomPanelHeight);

  double get swimlaneAbsoluteMaxWidth => setup.maxHourCount * setup.blockSize.width;

  double get swimlaneAbsoluteMaxHeight => setup.dataPoints.length * setup.blockSize.height;

  Size get blockSize => setup.blockSize;

  static SchedulerData? _maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SchedulerData>();
  }

  static SchedulerData of(BuildContext context) {
    final SchedulerData? result = _maybeOf(context);
    assert(result != null, 'No Dimensions found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant SchedulerData oldWidget) {
    return oldWidget.blockSize.height != blockSize.height && oldWidget.blockSize.width != blockSize.width;
  }

  double get preferredInnerHeight {
    double _preferredHeight = ((innerHeight / blockSize.height).floor() * blockSize.height);
    return _preferredHeight + (cardSeparatorHeight * ((_preferredHeight / blockSize.height) - 1));
  }

  double get preferredInnerWidth => (innerWidth / blockSize.width).floor() * blockSize.width;

  double get cardSeparatorHeight => _cardSeparatorHeight;
}
