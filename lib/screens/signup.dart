import 'package:covidapp/screens/loginpage.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:covidapp/widgets/add_task_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String test = '';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        title: Text("$test", style: HeadingStyle),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(
                title: "Email",
                hint: "Enter your Email",
                hide: false,
                controller: _emailController,
              ),
              MyInputField(
                title: "Password",
                hint: "Enter your Password",
                hide: true,
                controller: _passwordController,
              ),
              MyInputField(
                title: "Confirm Password",
                hint: "Re-enter your password",
                hide: true,
                controller: _confirmPasswordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddTaskButton(
                          label: "Sign Up",
                          onTap: () async {
                            try {
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                Get.snackbar("Error", "Passwords don't match",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    icon: Icon(Icons.warning_amber_outlined));
                              } else {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                            } on FirebaseAuthException catch (e) {
                              print(e.code);
                              switch (e.code) {
                                case "email-already-in-use":
                                  {
                                    Get.snackbar(
                                        "Error", "Email already in use",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));

                                    break;
                                  }
                                case "weak-password":
                                  {
                                    Get.snackbar("Weak Password",
                                        "Password must be 8 characters",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));

                                    break;
                                  }
                              }
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddTaskButton(
                          label: "Back",
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
