import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/chatscreen.dart';
import 'package:fyp/Screens/login_screen.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Doctor Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff374366),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    // Add doctor's profile picture here
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Doctor Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.chat),
            //   title: const Text('Chats'),
            //   onTap: () {
            //     // Handle chat navigation
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ChatScreen()),
            //     );
            //     // Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              onTap: () {
                // Handle appointment navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Patients'),
              onTap: () {
                // Handle patient navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff374366),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'View Reports',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Patients',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Baby name ${index + 1}'),
                    subtitle: Text('Age: ${6 + index}'),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
