import 'package:covidapp/services/firestore_service.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_bar.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderState();
}

class _ReminderState extends State<ReminderPage> {
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: _addAppBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          // _showTasks(),
          ElevatedButton(
              onPressed: (() {
                print(FirestoreService().getTasks().asStream());
              }),
              child: Text("tap me"))
          // StreamBuilder(
          //     stream: _tasks.snapshots(),
          //     builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          //       if (streamSnapshot.hasData) {
          //         return Expanded(
          //           child: ListView.builder(
          //               itemCount: streamSnapshot.data!.docs.length,
          //               itemBuilder: (context, index) {
          //                 final docsnap = streamSnapshot.data!.docs[index];
          //                 return AnimationConfiguration.staggeredList(
          //                     position: index,
          //                     child: SlideAnimation(
          //                       child: FadeInAnimation(
          //                         child: Row(
          //                           children: [
          //                             GestureDetector(
          //                               onTap: (() {
          //                                 print("Tapped");
          //                               }),
          //                               child: Text(docsnap['title']),
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                     ));

          //                 // return Container(
          //                 //   width: 100,
          //                 //   height: 50,
          //                 //   color: Colors.green,
          //                 //   margin: EdgeInsets.only(bottom: 10),
          //                 //   child: Text(docsnap['title']),
          //                 // );
          //               }),
          //         );
          //       } else {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }))
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (_, context) {
          return Container(
            width: 100,
            height: 50,
            color: Colors.green,
            margin: EdgeInsets.only(bottom: 10),
          );
        },
      ),
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
          AddTaskButton(
              label: "+ Add Task", onTap: () => Get.to(() => AddTaskPage()))
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color(0xFF4e5ae8),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }
}

_addAppBar() {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 242, 249, 255),
    elevation: 0,
  );
}
