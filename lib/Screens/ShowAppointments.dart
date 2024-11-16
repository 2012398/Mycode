import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/db.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;

class ShowAppointments extends StatefulWidget {
  const ShowAppointments({super.key});

  @override
  State<ShowAppointments> createState() => _ShowAppointmentsState();
}

class _ShowAppointmentsState extends State<ShowAppointments> {
  final user = FirebaseAuth.instance.currentUser!;

  List<dynamic> appointments = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('${db.dblink}/showappointments/${user.displayName!}'));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        appointments = responseData['appointments'];
      });
    } else {
      print('Failed to load appointments: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Appointments'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : appointments.isEmpty
          ? const Center(child: Text('No appointments found'))
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          final appointmentId = appointment['data']['AppointmentId'];
          final status = appointment['data']['Status'];

          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Color(0xff374366),
                ),
                title: Text(
                  'Appointment by: ${appointment['data']['PatientName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: status == 'Approved'
                        ? Colors.green
                        : (status == 'Rejected'
                        ? Colors.red
                        : Colors.blue),
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      'Time slot: ${appointment['data']['selectedTime']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    /*Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            approveAppointment(
                                appointment['data']['appointmentId'],
                                'Approved');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color(0xff374366),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                'Approve',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                           print(
                                appointment['data']['appointmentId'],);
                            approveAppointment(
                                appointment['data']['appointmentId'],
                                'Rejected');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color(0xff374366),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )*/
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> approveAppointment(String appointmentId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('${db.dblink}/AppointmentApprove'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'AppointmentId': appointmentId, 'status': status}),
      );

      if (response.statusCode == 200) {
        // Refresh orders to reflect the updated status
        fetchAppointments();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment Status Updated successfully!'),
          ),
        );
      } else {
        final errorMsg = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update appointment: $errorMsg'),
          ),
        );
      }
    } catch (e) {
      print('Error updating appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating appointment. Please try again later.'),
        ),
      );
    }
  }
}
