import 'package:adda/booking_facility.dart';
import 'package:flutter/material.dart';

class FacilityBookingScreen extends StatefulWidget {
  const FacilityBookingScreen({
    super.key,
  });

  @override
  _FacilityBookingScreenState createState() => _FacilityBookingScreenState();
}

class _FacilityBookingScreenState extends State<FacilityBookingScreen> {
  final BookingFacilty bookingfacilty = BookingFacilty();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedFacility;
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      bookFacilityAndReset();
    }
  }

  void bookFacility({
    required String facility,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    double? bookingAmount = bookingfacilty.bookFacility(
      facility: facility,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );

    if (bookingAmount != null) {
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Booking Successful',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Facility: $facility\nAmount: Rs. ${bookingAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Booking Failed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'The selected time slot is already booked for $facility.',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void bookFacilityAndReset() {
    bookFacility(
      date: selectedDate!,
      endTime: selectedEndTime!,
      facility: selectedFacility!,
      startTime: selectedStartTime!,
    );
    setState(() {
      selectedFacility = null;
      selectedDate = null;
      selectedStartTime = null;
      selectedEndTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facility Booking'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedFacility,
                  onChanged: (value) {
                    setState(() {
                      selectedFacility = value!;
                    });
                  },
                  items: bookingfacilty.facilities.map((facility) {
                    return DropdownMenuItem(
                      value: facility,
                      child: Text(facility),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Facility',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a facility';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                  validator: (value) {
                    if (selectedDate == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? selectedDate!.toString().split(' ')[0]
                        : '',
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedStartTime = pickedTime;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                        ),
                        validator: (value) {
                          if (selectedStartTime == null) {
                            return 'Please select a start time';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: selectedStartTime != null
                              ? selectedStartTime?.format(context)
                              : '',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedEndTime = pickedTime;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                        ),
                        validator: (value) {
                          if (selectedStartTime == null) {
                            return 'Please select a end time';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: selectedEndTime != null
                              ? selectedEndTime?.format(context)
                              : '',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Book Facility',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (bookingfacilty.bookings.isNotEmpty) ...[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Bookings",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  bookingfacilty.bookings[index].facility,
                ),
                trailing: Text(
                  "Rs. ${bookingfacilty.bookings[index].amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    '${bookingfacilty.bookings[index].date.toString().split(' ')[0]} (${bookingfacilty.bookings[index].startTime.format(context)} - ${bookingfacilty.bookings[index].endTime.format(context)})'),
              ),
              itemCount: bookingfacilty.bookings.length,
            ),
          ],
        ],
      ),
    );
  }
}
