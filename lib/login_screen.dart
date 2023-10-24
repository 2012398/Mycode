import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/menu_screen1.dart';
import 'package:fyp/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
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
              child: Image.asset("images/welcome.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Hello, BabyBloomer!",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: FormFields(scaffoldKey: _scaffoldKey),
          )
        ],
      ),
    );
  }
}

class FormFields extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const FormFields({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = "";
  final ButtonStyle bluestyle = ElevatedButton.styleFrom(
    padding: (const EdgeInsets.fromLTRB(130, 20, 130, 20)),
    textStyle:
        GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                      borderRadius: BorderRadius.all(Radius.elliptical(40, 40)),
                    )),
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
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(40, 40)))),
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
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = showForgotPassBottomSheet,
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
          height: 10,
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
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void showForgotPassBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Make the bottom sheet full-screen
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              // Background overlay
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Content of the bottom sheet
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(40, 40),
                    topRight: Radius.elliptical(40, 40),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [Container()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen1()),
      );
    } on FirebaseAuthException {
      setState(() {
        _errorMessage = "Incorrect Email/pass";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_printLatestValue);
    passwordController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    final text = emailController.text;
    final pass = passwordController.text;

    print('Second text field: $text (${text.characters.length})');
    print('Second text field: $pass (${pass.characters.length})');
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
}
