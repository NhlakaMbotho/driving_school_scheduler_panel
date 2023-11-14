import 'package:driving_school_scheduler_panel/constants/colors.dart';
import 'package:flutter/material.dart';

class SchedulerCard {
  final DateTime startTime;
  final DateTime endTime;
  final String label;

  const SchedulerCard(this.startTime, this.endTime, this.label);

  LessonStatus getStatus() {
    return startTime.hour < 12 ? LessonStatus.COMPLETED : LessonStatus.PLANNED;
  }
}

class DataPoint {
  final String label;
  final Image image;
  final List<SchedulerCard> cardList;

  const DataPoint(this.label, this.image, this.cardList);
}
