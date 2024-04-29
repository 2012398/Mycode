import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddBaby.dart';

// ignore: camel_case_types
class Baby_profile extends StatelessWidget {
  const Baby_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Details'),
        backgroundColor: const Color(0xff374366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailItem(
              label: 'Baby Name',
              value: 'John Doe',
              icon: Icons.child_care,
              color: Colors.blue,
            ),
            _buildDetailItem(
              label: 'Blood Group',
              value: 'O+',
              icon: Icons.opacity,
              color: Colors.green,
            ),
            _buildDetailItem(
              label: 'Age',
              value: '6 months',
              icon: Icons.calendar_today,
              color: Colors.orange,
            ),
            _buildDetailItem(
              label: 'Height',
              value: '60 cm',
              icon: Icons.height,
              color: Colors.purple,
            ),
            _buildDetailItem(
              label: 'Weight',
              value: '7 kg',
              icon: Icons.fitness_center,
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBaby()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            textStyle:
                GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400),
            backgroundColor: const Color(0xff374366),
          ),
          child: const Text('Add Baby'),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
