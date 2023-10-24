import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Create Account",
            style: GoogleFonts.montserrat(
                fontSize: 24, fontWeight: FontWeight.w500),
          )),
          const Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: SignupForm(),
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = "";
  final ButtonStyle bluestyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
    textStyle:
        GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email.";
                  }
                  if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$")
                      .hasMatch(value)) {
                    return "Email not in the correct format.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(
                  hintText: "Mobile Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your mobile number.";
                  }
                  if (!RegExp(r"^(03[0-9]{9})$").hasMatch(value)) {
                    return "Phone number is invalid";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password.";
                  }
                  return null;
                },
              ),
              // Display error message if applicable
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 100),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.elliptical(40, 40)),
            child: ElevatedButton(
              style: bluestyle,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signup();
                }
              },
              child: const Text("Create Account"),
            ),
          ),
        ),
        // Already have an account? Sign in link
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: GoogleFonts.rubik(color: Colors.black),
                ),
                TextSpan(
                  text: "Sign In",
                  style: GoogleFonts.rubik(
                    color: const Color(0xff374366),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // You can add code to save user details, navigate to another screen, etc., here.
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? "An error occurred";
      });
    }
  }
}
