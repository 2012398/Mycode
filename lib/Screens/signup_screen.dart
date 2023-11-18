// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/Screens/login_screen.dart';
import 'package:fyp/Screens/menu_screen1.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              "Create Account",
              style: GoogleFonts.montserrat(
                  fontSize: 24, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: SignupForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = "";
  final ButtonStyle bluestyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(70, 20, 70, 20),
    textStyle:
        GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final mobileController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                    return "Please enter your name.";
                  }
                  if (!RegExp(r"^[A-Za-z]+ [A-Za-z]+$").hasMatch(value)) {
                    return "Please enter your full name";
                  }
                  return null;
                },
                onChanged: (value) {
                  validateName(value);
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
                onChanged: (value) {
                  validateEmail(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(
                  hintText: "03xxxxxxxxx",
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
                onChanged: (value) {
                  validateMobile(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _isPasswordHidden,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password.";
                  }
                  return null;
                },
                onChanged: (value) {
                  validatePass(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _isConfirmPasswordHidden,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_isConfirmPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password.";
                  }

                  if (value != passwordController.text) {
                    return "Password do not match.";
                  }
                  return null;
                },
              ),
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
          padding: const EdgeInsets.only(bottom: 10, top: 70),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.elliptical(40, 40)),
            child: ElevatedButton(
              style: bluestyle,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // signup();
                  Register();
                }
              },
              child: const Text("Create Account"),
            ),
          ),
        ),
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
                          builder: (context) => const LoginScreen(),
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

 Future<void> Register() async {
    final String apiUrl = 'http://192.168.100.81:3000/signup'; // Replace with your server URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
        'displayName': nameController.text.toString(),
        'Contact':mobileController.text.toString()
      }),
    );

    if (response.statusCode == 201) {
      // User created successfully
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Created Succesfully ${responseData['userId']}')));
      
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      print('User created successfully. User ID: ${responseData['userId']}');
    } else if(response.statusCode == 400){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Already Exists.')));
      }else {
      // Error occurred
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }




  Future<void> signup() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      String uid = userCredential.user!.uid;

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!!'),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account already exists'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_printLatestValue);
    passwordController.addListener(_printLatestValue);
    mobileController.addListener(_printLatestValue);
    nameController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    final email = emailController.text;
    final pass = passwordController.text;
    final numb = mobileController.text;
    final name = nameController.text;

    print('Email field: $email (${email.characters.length})');
    print('Password field: $pass (${pass.characters.length})');
    print('Mobile field: $numb (${numb.characters.length})');
    print('Name field: $name (${name.characters.length})');
  }

  void validateName(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Name cannot be empty";
      });
    } else if (!RegExp(r"^[A-Za-z]+ [A-Za-z]+$").hasMatch(val)) {
      setState(() {
        _errorMessage = "Please enter your full name";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email cannot be empty";
      });
    } else if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(val)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void validatePass(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Password cannot be empty";
      });
    } else if (val.length < 6) {
      setState(() {
        _errorMessage = "Password must contain at least six characters";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void validateMobile(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Phone number cannot be empty";
      });
    } else if (!RegExp(r"^(03[0-9]{9})$").hasMatch(val)) {
      setState(() {
        _errorMessage = "Please enter a valid phone number";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
