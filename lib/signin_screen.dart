import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle bluestyle = ElevatedButton.styleFrom(
    padding: (const EdgeInsets.fromLTRB(50, 20, 50, 20)),
    textStyle:
        GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
    backgroundColor: const Color(0xff374366),
    foregroundColor: Colors.white,
  );
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  bottomRight: Radius.elliptical(40, 40)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset("images/welcome.png")),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(Icons.email_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(Icons.password_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: bluestyle,
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
