import 'package:adda/booking_facility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // given when thenn
  test(
    'Given BookingFacilty class when it is instantiated then length of bookings list should be 0',
    () {
      // Arrange
      final BookingFacilty bookingFacilty = BookingFacilty();

      // Act
      final val = bookingFacilty.bookings.length;

      // Assert
      expect(val, 0);
    },
  );
  test(
    'Given BookingFacilty class when a booking is added then length of bookings list should be 1 and booking amount for this case is 600',
    () {
      // Arrange
      final BookingFacilty bookingFacilty = BookingFacilty();

      // Act
      double? bookingAmount = bookingFacilty.bookFacility(
        date: DateTime.now(),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
        facility: "Clubhouse",
      );
      final val = bookingFacilty.bookings.length;

      // Assert
      expect(val, 1);
      expect(bookingAmount, 600);
    },
  );
  test(
    'Given BookingFacilty class when a booking is added then length of bookings list should be 1 and booking amount for this case is 3000. i.e for time sloot between 4 pm and 10 pm price is 500 rs/hour for Clubhouse',
    () {
      // Arrange
      final BookingFacilty bookingFacilty = BookingFacilty();

      // Act
      double? bookingAmount = bookingFacilty.bookFacility(
        date: DateTime.now(),
        startTime: const TimeOfDay(hour: 16, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        facility: "Clubhouse",
      );
      final val = bookingFacilty.bookings.length;

      // Assert
      expect(val, 1);
      expect(bookingAmount, 3000);
    },
  );
  test(
    'Given BookingFacilty class when a booking is added that is already booked for that time slot then that booking should not be added i.e. bookings length should be 1 only and booking amount should be null ',
    () {
      // Arrange
      final BookingFacilty bookingFacilty = BookingFacilty();

      // Act
      double? bookingAmount1 = bookingFacilty.bookFacility(
        date: DateTime.now(),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
        facility: "Clubhouse",
      );
      double? bookingAmount2 = bookingFacilty.bookFacility(
        date: DateTime.now(),
        startTime: const TimeOfDay(hour: 12, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
        facility: "Clubhouse",
      );
      final val = bookingFacilty.bookings.length;

      // Assert
      expect(val, 1);
      expect(bookingAmount2, null);
    },
  );
}
