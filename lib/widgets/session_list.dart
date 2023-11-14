import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/widgets/lesson_widget.dart';
import 'package:flutter/material.dart';

class InstructorSessionLine extends StatelessWidget {
  final DataPoint instructor;
  const InstructorSessionLine(this.instructor, {super.key});

  int getHourByIndex(int index, int startHour) {
    return startHour + index;
  }

  List<Widget> getBlocks(SchedulerData dimensions) {
    int tradingHours = dimensions.setup.maxHourCount;
    int tradingStartHour = dimensions.setup.startHour;
    List<Widget> list = [];

    if (instructor.cardList.length == 0) {
      return [
        Container(
          color: Colors.transparent,
          width: dimensions.blockSize.width,
        )
      ];
    }

    int i = 0;
    do {
      int currentHour = getHourByIndex(i, tradingStartHour);

      try {
        SchedulerCard _lesson = instructor.cardList.firstWhere((lesson) => lesson.startTime.hour == currentHour);
        if (_lesson.startTime.hour == _lesson.endTime.hour) {
          i++;
          continue;
        }
        int hourCount = _lesson.endTime.hour - _lesson.startTime.hour;
        double currentLessonWidth = dimensions.blockSize.width * hourCount;
        list.add(LessonWidget(_lesson, currentLessonWidth, dimensions.blockSize.height));
        i += hourCount;
      } on StateError {
        int k = i;
        double width = 0;
        while (instructor.cardList.any((lesson) => lesson.startTime.hour == getHourByIndex(k, tradingStartHour)) &&
            k < tradingHours) {
          width += dimensions.blockSize.width;
          k++;
        }
        if (k > i) {
          list.add(SizedBox(width: width));
        }
        i = k;
      }
    } while (i < tradingHours);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    var dimensions = SchedulerData.of(context);
    return SizedBox(
      height: dimensions.blockSize.height,
      child: Row(
        children: getBlocks(dimensions),
      ),
    );
  }
}
