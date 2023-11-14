import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:flutter/material.dart';

class TimestampGuideLines extends StatelessWidget {
  const TimestampGuideLines({super.key});

  List<Widget> getTimestampWidgets(BuildContext context, SchedulerData schedulerDimensions) {
    List<Widget> list = [];

    for (var i = 0; i < schedulerDimensions.setup.maxHourCount; i++) {
      list.add(
        Container(
          color: Colors.transparent,
          height: getHeight(context, schedulerDimensions.blockSize.height),
          width: schedulerDimensions.blockSize.width,
          child: Row(
            children: [
              Container(
                width: 6,
                height: getHeight(context, schedulerDimensions.blockSize.height),
                color: Colors.grey.withOpacity(.08),
              )
            ],
          ),
        ),
      );
    }

    return list;
  }

  double getHeight(BuildContext context, cardHeight) {
    var _instructors = SchedulerData.of(context).setup.dataPoints;
    var fullLength = _instructors.length * cardHeight;
    return fullLength + ((_instructors.length - 1) * 16);
  }

  @override
  Widget build(BuildContext context) {
    var schedulerDimensions = SchedulerData.of(context);
    return SizedBox(
      height: schedulerDimensions.preferredInnerHeight,
      width: schedulerDimensions.swimlaneAbsoluteMaxWidth,
      child: SizedBox(
        child: Row(children: getTimestampWidgets(context, schedulerDimensions)),
      ),
    );
  }
}
