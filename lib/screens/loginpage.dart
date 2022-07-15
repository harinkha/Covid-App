import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/splashscreen.dart';
import 'package:covidapp/screens/tabs.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (context) => TabViews()));
    // }
  }

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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddTaskButton(
                          label: "Log In",
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => TabViews()));
                            } on FirebaseAuthException catch (e) {
                              print(e.code);
                              switch (e.code) {
                                case "invalid-email":
                                case "wrong-password":
                                case "user-not-found":
                                  {
                                    Get.snackbar(
                                        "Error", "Wrong Email or Password",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));
                                    break;
                                  }
                                case "user-disabled":
                                  {
                                    Get.snackbar("Error", "User is disabled",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));
                                    break;
                                  }
                              }
                            }

                            setState(() {
                              if (FirebaseAuth.instance.currentUser != null) {
                                test = 'Logged in';
                                print(test);
                                print(FirebaseAuth.instance.currentUser?.email);
                              }
                            });
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddTaskButton(
                          label: "Sign Up",
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              _emailController.clear();
                              _passwordController.clear();
                              Get.snackbar("Sign Up Successful",
                                  "Please Proceed to Log In",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  icon: Icon(Icons.done_outline));
                            } on FirebaseAuthException catch (e) {
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
                                        "Password should be at least 6 characters",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));
                                    break;
                                  }
                                case "invalid-email":
                                  {
                                    Get.snackbar(
                                        "Invalid Email", "Enter a valid Email",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        icon:
                                            Icon(Icons.warning_amber_outlined));
                                    break;
                                  }
                              }
                            }
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
