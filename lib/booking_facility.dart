import 'package:adda/models/booking.dart';
import 'package:adda/models/timeslot.dart';
import 'package:adda/utils.dart';
import 'package:flutter/material.dart';

class BookingFacilty {
  final List<String> facilities = ['Clubhouse', 'Tennis Court'];
  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking({required Booking booking}) {
    bookings.add(booking);
  }

  double? bookFacility({
    required String facility,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    final selectedFacility = facilities.firstWhere((f) => f == facility);

    final timeSlot = TimeSlot(start: startTime, end: endTime);

    if (isTimeSlotAvailable(
      bookings: _bookings,
      date: date,
      facility: selectedFacility,
      timeSlot: timeSlot,
    )) {
      final double bookingAmount;

      if (selectedFacility == "Clubhouse") {
        if (toDouble(startTime) >= 16 && toDouble(endTime) <= 22) {
          bookingAmount = (toDouble(endTime) - toDouble(startTime)).abs() * 500;
        } else {
          bookingAmount = (toDouble(endTime) - toDouble(startTime)).abs() * 100;
        }
      } else {
        bookingAmount = (toDouble(endTime) - toDouble(startTime)).abs() * 50;
      }

      addBooking(
        booking: Booking(
          facility: selectedFacility,
          date: date,
          startTime: startTime,
          endTime: endTime,
          amount: bookingAmount,
        ),
      );

      return bookingAmount;
    } else {
      return null;
    }
  }
}
