import 'package:covidapp/widgets/DaysLeft.dart';
import 'package:covidapp/widgets/button_widget.dart';
import 'package:covidapp/widgets/duration.dart';
import 'package:covidapp/widgets/durationText.dart';
import 'package:covidapp/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:covidapp/services/notification_service.dart';

class IsolationPage extends StatefulWidget {
  const IsolationPage({Key? key}) : super(key: key);

  @override
  State<IsolationPage> createState() => _IsolationPageState();
}

class _IsolationPageState extends State<IsolationPage> {
  DateTime dateTime = DateTime.now();
  final DateTime endDate = DateTime.now().add(Duration(days: 14));
  int later = 14;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 249, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        title: Text(
          "                14 days\n Self-isolation countdown",
          style: GoogleFonts.archivoBlack(
              color: Color.fromARGB(255, 154, 155, 159)),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 10),
                  child: Daysleft(later),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                DurationText('Starting Date'),
                                DurationTime(
                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          DurationText('At'),
                          DurationTime(DateFormat('hh:mm a').format(dateTime)),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonWidget(
                  onClicked: (() {
                    Utils.showSheet(context, child: buildDateTimePicker(),
                        onClicked: () {
                      Navigator.pop(context);
                      setState(() {
                        later = endDate.difference(dateTime).inDays;
                      });
                    });
                  }),
                  label: 'Date & Time',
                )
              ],
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDateTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 2015,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.dateAndTime,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}
