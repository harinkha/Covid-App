import 'package:covidapp/models/taskModel.dart';
import 'package:covidapp/screens/reminderpage.dart';
import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/add_task_button.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final db = FirebaseFirestore.instance;
  Task task = Task('', '', '', false, '', '', '', '');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String error = "";
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    0,
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = 'None';
  List<String> repeatList = [
    "None",
    "Daily",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addAppBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Medicine",
                style: HeadingStyle,
              ),
              MyInputField(
                hide: false,
                title: "Title",
                hint: "Enter your Title",
                controller: _titleController,
              ),
              MyInputField(
                hide: false,
                title: "Note",
                hint: "Enter your Note",
                controller: _noteController,
              ),
              MyInputField(
                hide: false,
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDate();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      hide: false,
                      title: "Start Date",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: (() {
                          _getTime(isStartTime: true);
                        }),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      hide: false,
                      title: "End Date",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: (() {
                          _getTime(isStartTime: false);
                        }),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              MyInputField(
                hide: false,
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                hide: false,
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      error,
                      style: warningStyle,
                    ),
                    AddTaskButton(
                        label: "Create Task",
                        onTap: () async {
                          _addTaskToDb();
                          final uid =
                              await FirebaseAuth.instance.currentUser?.uid;
                          await db
                              .collection('userData')
                              .doc(uid)
                              .collection('tasks')
                              .add(task.toJson());
                          Get.back();
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

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add to database

      Navigator.pop(context);
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning_amber_rounded));
    }
  }

  _getDate() async {
    DateTime? _picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (_picker != null) {
      setState(() {
        _selectedDate = _picker;
      });
    } else {
      print('not working');
    }
  }

  _getTime({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('canceled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }

  _addTaskToDb() {
    task = Task(
        _titleController.text,
        DateFormat.yMd().format(_selectedDate),
        _endTime,
        false,
        _noteController.text,
        _selectedRepeat,
        _startTime,
        _selectedRemind.toString());
  }

  _addAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
