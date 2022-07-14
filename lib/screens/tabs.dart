import 'package:covidapp/screens/homepage.dart';
import 'package:covidapp/screens/isolation.dart';
import 'package:covidapp/screens/loginpage.dart';
import 'package:covidapp/screens/profilepage.dart';
import 'package:covidapp/screens/reminderpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabViews extends StatefulWidget {
  const TabViews({
    Key? key,
  }) : super(key: key);

  @override
  State<TabViews> createState() => _TabViewsState();
}

class _TabViewsState extends State<TabViews> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: CupertinoColors.black,
          inactiveColor: CupertinoColors.black.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(
                label: 'Quarantine',
                icon: Icon(CupertinoIcons.lab_flask_solid)),
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
              return ProfilePage();
          }
        });
  }
}
