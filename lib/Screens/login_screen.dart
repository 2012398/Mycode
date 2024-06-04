// ignore_for_file: unused_field

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/Screens/menu_screen1.dart';
import 'package:fyp/Screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(40, 40),
                  bottomRight: Radius.elliptical(40, 40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset("assets/images/welcome.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 50,
              ),
              child: Text(
                "Hello, BabyBloomer!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: FormFields(),
            ),
          ],
        ),
      ),
    );
  }
}

class FormFields extends StatefulWidget {
  const FormFields({Key? key}) : super(key: key);

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = "";
  final ButtonStyle bluestyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
    textStyle: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 0,
    ),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Toggle password visibility

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(40, 40),
                    ),
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
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                // Toggle based on this flag
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(40, 40),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password.";
                  }
                  if (value.length < 6) {
                    return "Invalid password";
                  }
                  return null;
                },
                onChanged: (value) {
                  validatePass(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Forgot password?",
                            style: GoogleFonts.rubik(
                              color: const Color(0xff374366),
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showForgotPassDialog(context);
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.elliptical(40, 40)),
            child: ElevatedButton(
              style: bluestyle,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
              child: const Text("Login"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account? ",
                  style: GoogleFonts.rubik(color: Colors.black),
                ),
                TextSpan(
                  text: "Sign Up",
                  style: GoogleFonts.rubik(
                    color: const Color(0xff374366),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
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

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-      .]{2,4}$")
        .hasMatch(val)) {
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
        _errorMessage = "Password must contain at least six characters";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  Future<void> login() async {
    try {
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MenuScreen1()));
      print('Login successful. User: ${authResult.user}');
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

void showForgotPassDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(20.0),
          child: ForgotPasswordForm(),
        ),
      );
    },
  );
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController emailController1 = TextEditingController();
  final ButtonStyle button = ElevatedButton.styleFrom(
    padding: (const EdgeInsets.fromLTRB(20, 20, 20, 20)),
    textStyle:
        GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  String _errorMessage1 = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: TextFormField(
                    controller: emailController1,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(40, 40)),
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
                ),
                // const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage1,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(10, 10)),
                  child: ElevatedButton(
                    style: button,
                    onPressed: () {
                      if (validateEmail(emailController1.text)) {
                        sendResetLink(emailController1.text);
                      }
                    },
                    child: const Text("Send Reset Link"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        _errorMessage1 = "Email can not be empty";
      });
      return false;
    } else if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      setState(() {
        _errorMessage1 = "Invalid Email Address";
      });
      return false;
    } else {
      setState(() {
        _errorMessage1 = "";
      });
      return true;
    }
  }

  void sendResetLink(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent successfully.'),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage1 =
            "An error occurred. Please check your email and try again.";
      });
    }
  }
}
