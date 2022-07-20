import 'package:covidapp/screens/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:get/get.dart';
import 'package:covidapp/services/notification_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var notifyHelper = NotifyHelper();
  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

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
                title: "New Password",
                hint: "Enter your New Password",
                hide: true,
                controller: _passwordController,
              ),
              MyInputField(
                title: "Confirm New Password",
                hint: "Re-enter your new password",
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
                          label: "Change Password",
                          onTap: () async {
                            try {
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                Get.snackbar("Error", "Passwords don't match",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    icon: Icon(Icons.warning_amber_outlined));
                              } else {
                                await FirebaseAuth.instance.currentUser!
                                    .updatePassword(_passwordController.text);
                                notifyHelper.displayNotification(
                                    title: "Password Changed", body: "Success");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()));
                              }
                            } on FirebaseAuthException catch (e) {
                              print(e.code);
                              Get.snackbar("Error", "Something went wrong",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  icon: Icon(Icons.warning_amber_outlined));
                            }
                          }),
                    ),
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
