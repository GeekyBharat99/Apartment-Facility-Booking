import 'package:adda/models/booking.dart';
import 'package:adda/models/timeslot.dart';
import 'package:flutter/material.dart';

bool isTimeBefore(TimeOfDay firstTime, TimeOfDay secondTime) {
  return firstTime.hour < secondTime.hour ||
      (firstTime.hour == secondTime.hour &&
          firstTime.minute < secondTime.minute);
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

bool isTimeSlotAvailable({
  required String facility,
  required DateTime date,
  required TimeSlot timeSlot,
  required List<Booking> bookings,
}) {
  for (final booking in bookings) {
    if (booking.facility == facility &&
        booking.date == date &&
        toDouble(booking.endTime) > toDouble(timeSlot.start) &&
        toDouble(booking.startTime) < toDouble(timeSlot.end)) {
      return false;
    }
  }
  return true;
}
