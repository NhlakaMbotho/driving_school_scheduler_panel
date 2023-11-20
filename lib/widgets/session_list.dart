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
        //TODO: revisit this
        Container(
          color: Colors.transparent,
          width: dimensions.blockSize.width,
        )
      ];
    }

    for (int i = 0; i < instructor.cardList.length; i++) {
      SchedulerCard currentLesson = instructor.cardList[i];

      if (i == 0 && currentLesson.startTime.hour > tradingStartHour) {
        list.add(SizedBox(width: (currentLesson.startTime.hour - tradingStartHour) * dimensions.blockSize.width));
        continue;
      }

      if (i > 0 && instructor.cardList[i - 1].endTime.hour < currentLesson.startTime.hour) {
        list.add(SizedBox(
            width:
                (currentLesson.startTime.hour - instructor.cardList[i - 1].endTime.hour) * dimensions.blockSize.width));
      }

      list.add(
        LessonWidget(
            currentLesson,
            (currentLesson.endTime.hour - currentLesson.startTime.hour) * dimensions.blockSize.width,
            dimensions.blockSize.height),
      );
    }

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
