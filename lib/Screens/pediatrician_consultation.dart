import 'package:flutter/material.dart';

class ConsultationScreen extends StatefulWidget {
  @override
  _ConsultationScreenState createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String selectedTime = 'Select Time';
  DateTime selectedDate = DateTime.now();

  // Sample list of doctors
  List<Doctor> doctors = [
    Doctor(name: 'Dr. Ali', experience: '10 years', rating: 4.5, reviews: 120),
    Doctor(
        name: 'Dr. Ahmed bux', experience: '8 years', rating: 4.2, reviews: 90),
    Doctor(
        name: 'Dr. Khalil', experience: '6 years', rating: 4.1, reviews: 1000),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: Text('Pediatrician Consultation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Doctor:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display list of doctors
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: doctors[index],
                    onDateAndTimeSelected: (selectedTime) {
                      // TODO: Handle date and time selection for the specific doctor
                      // You can use selectedDate and selectedTime here
                    },
                    onDateSelected: (selectedDate) {
                      setState(() {
                        this.selectedDate = selectedDate;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String experience;
  final double rating;
  final int reviews;

  Doctor(
      {required this.name,
      required this.experience,
      required this.rating,
      required this.reviews});
}

class DoctorCard extends StatefulWidget {
  final Doctor doctor;
  final Function(DateTime selectedTime) onDateAndTimeSelected;
  final Function(DateTime selectedDate) onDateSelected;

  DoctorCard({
    required this.doctor,
    required this.onDateAndTimeSelected,
    required this.onDateSelected,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  String selectedTime = 'Select Time';
  DateTime selectedDate = DateTime.now();

  Future<void> _showTimePicker() async {
    TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null) {
      setState(() {
        selectedTime = '${selected.format(context)}';
      });
      widget.onDateAndTimeSelected(DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selected.hour,
          selected.minute));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doctor.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Experience: ${widget.doctor.experience}'),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(
                    '${widget.doctor.rating} (${widget.doctor.reviews} reviews)'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff374366)),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text('Select Date'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff374366)),
                    onPressed: () {
                      _showTimePicker();
                    },
                    child: Text(selectedTime),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                // TODO: Implement consultation request submission
              },
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
