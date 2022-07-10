import 'package:covidapp/theme.dart';
import 'package:covidapp/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

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
              MyInputField(title: "Title", hint: "Enter your Title"),
              MyInputField(title: "Note", hint: "Enter your Note"),
            ],
          ),
        ),
      ),
    );
  }

  _addAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      elevation: 0,
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
