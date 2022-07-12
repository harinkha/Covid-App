import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        title: Text("Get Started", style: HeadingStyle),
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
                controller: _emailController,
              ),
              MyInputField(
                title: "Password",
                hint: "Enter your Password",
                controller: _passwordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AddTaskButton(
                        label: "Log In",
                        onTap: () async {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          setState(() {});
                        })
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
