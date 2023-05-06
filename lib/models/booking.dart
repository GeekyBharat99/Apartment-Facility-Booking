import 'package:flutter/material.dart';

class Booking {
  final String facility;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double amount;

  Booking({
    required this.facility,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.amount,
  });
}
