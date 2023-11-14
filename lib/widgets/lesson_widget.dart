import 'package:driving_school_scheduler_panel/models/data_point.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class LessonWidget extends StatelessWidget {
  final SchedulerCard lesson;
  final double width;
  final double height;
  LessonWidget(this.lesson, this.width, this.height);

  Color getStatusColor() {
    switch (lesson.getStatus()) {
      case LessonStatus.COMPLETED:
        return Colors.green;
      case LessonStatus.PLANNED:
        return WidgetColors.Primary;
      case LessonStatus.MISSED:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  formatHour(int value) {
    String amPM = value > 12 ? 'PM' : 'AM';
    return (value < 10 ? '0$value' : '$value') + ' $amPM';
  }

  @override
  Widget build(BuildContext context) {
    double leftBarWidth = 2;
    return Row(
      children: [
        Container(
          width: leftBarWidth,
          color: getStatusColor(),
        ),
        Container(
          height: height,
          width: width - leftBarWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  height: height * 0.2,
                  width: lesson.label.length * 5.0,
                  child: Center(
                    child: Text(
                      '${lesson.label}',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${formatHour(lesson.startTime.hour)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    color: getStatusColor(),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
