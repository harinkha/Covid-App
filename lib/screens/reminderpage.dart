import 'package:covidapp/models/taskModel.dart';
import 'package:covidapp/services/firestore_service.dart';
import 'package:covidapp/services/notification_service.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_bar.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:covidapp/widgets/tasktile.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var notifyHelper = NotifyHelper();
  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  final _tasks = FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('tasks');
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
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return StreamBuilder(
        stream: _tasks.snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final docsnap = streamSnapshot.data!.docs[index];
                      if (docsnap['repeat'] == 'Daily') {
                        DateTime date = DateFormat.jm()
                            .parse(docsnap['startTime'].toString());
                        var myTime = DateFormat('HH:mm').format(date);
                        notifyHelper.scheduledNotification(
                          int.parse(myTime.toString().split(":")[0]),
                          int.parse(myTime.toString().split(":")[1]),
                          docsnap['title'],
                          docsnap['note'],
                        );
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        _showBottomSheet(context,
                                            docsnap['isCompleted'], docsnap.id);
                                      }),
                                      child: TaskTile(
                                          docsnap['title'],
                                          docsnap['endTime'],
                                          docsnap['startTime'],
                                          docsnap['note'],
                                          docsnap['date'],
                                          docsnap['isCompleted'],
                                          docsnap['repeat']),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                      if (docsnap['date'] ==
                          DateFormat.yMd().format(_selectedDate)) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        _showBottomSheet(context,
                                            docsnap['isCompleted'], docsnap.id);
                                      }),
                                      child: TaskTile(
                                          docsnap['title'],
                                          docsnap['endTime'],
                                          docsnap['startTime'],
                                          docsnap['note'],
                                          docsnap['date'],
                                          docsnap['isCompleted'],
                                          docsnap['repeat']),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      } else {
                        return Container();
                      }
                    }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
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
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, bool isCompleted, String id) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: isCompleted == true
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
          Spacer(),
          isCompleted == true
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _tasks.doc(id).update({'isCompleted': true});
                    Get.back();
                  },
                  clr: Color(0xFF4e5ae8),
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              _tasks.doc(id).delete();
              Get.back();
            },
            clr: Colors.red[300]!,
            context: context,
          ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: "Close",
            isClose: true,
            onTap: () {
              Get.back();
            },
            clr: Colors.red[300]!,
            context: context,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

_bottomSheetButton(
    {required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2, color: isClose == true ? Colors.grey[300]! : clr),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true ? Colors.transparent : clr,
      ),
      child: Center(
          child: Text(
        label,
        style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
      )),
    ),
  );
}

_addAppBar() {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 242, 249, 255),
    elevation: 0,
  );
}
