import 'package:covidapp/screens/changePassword.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'splashscreen.dart';
import 'reminderpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        title: Text("Profile", style: HeadingStyle),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    bottomSheetButton(
                        label: 'Log Out',
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()));
                        },
                        clr: Colors.red,
                        context: context),
                    SizedBox(
                      height: 20,
                    ),
                    bottomSheetButton(
                        label: 'Update Password',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChangePasswordPage()));
                        },
                        clr: Color(0xFF4e5ae8),
                        context: context),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
