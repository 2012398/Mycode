import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Create Account",
            style: GoogleFonts.montserrat(
                fontSize: 24, fontWeight: FontWeight.w500),
          )),
          const SizedBox(height: 5),
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
  const SignupForm({super.key});

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
                onChanged: (value) {
                  validateMobile(value);
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
                onChanged: (value) {
                  validatePass(value);
                },
              ),
              // Display error message if applicable

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

  Future<void> signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
  }

  void _printLatestValue() {
    final email = emailController.text;
    final pass = passwordController.text;
    final numb = mobileController.text;
    final name = nameController.text;

    print('Second text field: $email (${email.characters.length})');
    print('Second text field: $pass (${pass.characters.length})');
    print('Second text field: $numb (${numb.characters.length})');
    print('Second text field: $name (${name.characters.length})');
  }

  void validateName(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Name can not be empty";
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
        _errorMessage = "Email can not be empty";
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
        _errorMessage = "Password is invalid";
      });
    } else if (val.length < 6) {
      setState(() {
        _errorMessage = "Password must contain atleast six characters";
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
        _errorMessage = "Please enter valid phone number";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
