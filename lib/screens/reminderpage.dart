import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderState();
}

class _ReminderState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        elevation: 0,
      ),
      body: Column(children: [_addTaskBar()]),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: HeadingStyle,
                )
              ],
            ),
          ),
          AddTaskButton(label: "+ Add Task", onTap: () => null)
        ],
      ),
    );
  }
}
