import 'package:covidapp/screens/homepage.dart';
import 'package:covidapp/screens/isolation.dart';
import 'package:covidapp/screens/reminderpage.dart';
import 'package:covidapp/services/notification_service.dart';
import 'package:covidapp/widgets/DaysLeft.dart';
import 'package:covidapp/widgets/ScrollableRowIcons.dart';
import 'package:covidapp/widgets/dailycases.dart';
import 'package:covidapp/widgets/duration.dart';
import 'package:covidapp/widgets/durationText.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.black,
        inactiveColor: CupertinoColors.black.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(CupertinoIcons.home)),
          BottomNavigationBarItem(
              label: 'Quarantine', icon: Icon(CupertinoIcons.lab_flask_solid)),
          BottomNavigationBarItem(
              label: 'Reminders', icon: Icon(CupertinoIcons.bell_circle)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(CupertinoIcons.person)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return IsolationPage();
          case 2:
            return ReminderPage();
          case 3:
          default:
            return ReminderPage();
        }
      });
}
