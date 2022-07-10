import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addAppBar(),
      body: Container(),
    );
  }

  _addAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: Icon(size: 20, color: Colors.white, Icons.wb_sunny_outlined),
      ),
    );
  }
}
