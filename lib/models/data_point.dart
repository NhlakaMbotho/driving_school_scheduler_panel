import 'package:flutter/material.dart';

class Card {
  final DateTime startTime;
  final DateTime endTime;

  const Card(this.startTime, this.endTime);
}

class DataPoint {
  final String label;
  final Image image;
  final List<Card> cardList;

  const DataPoint(this.label, this.image, this.cardList);
}
