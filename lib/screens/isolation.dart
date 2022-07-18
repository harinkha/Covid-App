import 'package:covidapp/screens/reminderpage.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slide_countdown/slide_countdown.dart';

class IsolationPage extends StatefulWidget {
  const IsolationPage({Key? key}) : super(key: key);

  @override
  State<IsolationPage> createState() => _IsolationPageState();
}

class _IsolationPageState extends State<IsolationPage> {
  var notifyHelper = NotifyHelper();
  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  final db = FirebaseFirestore.instance;
  final _quarantineDate = FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Quarantine');
  DateTime dateTime = DateTime.now();
  bool isQuarantined = false;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 10),
                  child: Container(
                    height: 100,
                    child: StreamBuilder(
                      stream: _quarantineDate.snapshots(),
                      builder: ((context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          try {
                            var dateFromServer = streamSnapshot.data!.docs[0];
                            var endDate = DateFormat('MM/dd/yy')
                                .parse(dateFromServer['endDate']);
                            var endTime = DateFormat('HH:mm:ss')
                                .parse(dateFromServer['endTime']);
                            var end = DateTime(
                                endDate.year,
                                endDate.month,
                                endDate.day,
                                endTime.hour,
                                endTime.minute,
                                endTime.second);
                            print(end);
                            final dif =
                                end.difference(DateTime.now()).inSeconds;

                            print(dif);
                            isQuarantined = dateFromServer['isQuarantined'];

                            return SlideCountdown(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              duration: Duration(seconds: dif),
                              showZeroValue: true,
                              onDone: () async {
                                notifyHelper.displayNotification(
                                    title: 'Congratulations',
                                    body: 'Quarantine Over');
                                var collection = FirebaseFirestore.instance
                                    .collection('userData')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('Quarantine');
                                var snapshots = await collection.get();
                                for (var doc in snapshots.docs) {
                                  await doc.reference.delete();
                                }

                                setState(() {
                                  isQuarantined = false;
                                });
                              },
                              separatorType: SeparatorType.title,
                              slideDirection: SlideDirection.up,
                              separatorStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            );
                          } catch (e) {
                            return Container();
                          }
                        } else {
                          return Container(
                            child: Text("Chill"),
                          );
                        }
                      }),
                    ),
                  ),
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
                SizedBox(
                  height: 150,
                ),
                Opacity(
                  opacity: isQuarantined ? 0.2 : 1,
                  child: bottomSheetButton(
                    context: context,
                    clr: Colors.red,
                    onTap: (() async {
                      if (isQuarantined == true) {
                        return null;
                      }
                      setState(() {
                        isQuarantined = true;
                      });
                      DateTime _dateTime = DateTime.now();
                      DateTime ending = _dateTime.add(Duration(days: 14));
                      String date = DateFormat.yMd().format(_dateTime);
                      String endDate = DateFormat.yMd().format(ending);
                      String startTime =
                          DateFormat("HH:mm:ss").format(_dateTime).toString();
                      String endTime =
                          DateFormat("HH:mm:ss").format(ending).toString();
                      final uid = await FirebaseAuth.instance.currentUser?.uid;
                      await db
                          .collection('userData')
                          .doc(uid)
                          .collection('Quarantine')
                          .add({
                        'startTime': startTime,
                        'startDate': date,
                        'endDate': endDate,
                        'endTime': endTime,
                        'isQuarantined': true
                      });
                      if (isQuarantined == true) {}
                    }),
                    label: 'Start Quarantine Now',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Opacity(
                  opacity: isQuarantined ? 1.0 : 0.2,
                  child: bottomSheetButton(
                    context: context,
                    clr: Colors.blue,
                    onTap: (() async {
                      setState(() {
                        isQuarantined = false;
                      });
                      DateTime _dateTime = DateTime.now();
                      String date = DateFormat.yMd().format(_dateTime);

                      String startTime = DateFormat("hh:mm:ss a")
                          .format(DateTime.now())
                          .toString();
                      final uid = await FirebaseAuth.instance.currentUser?.uid;
                      var collection = FirebaseFirestore.instance
                          .collection('userData')
                          .doc(uid)
                          .collection('Quarantine');
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        await doc.reference.delete();
                      }
                      isQuarantined = false;
                    }),
                    label: 'Stop Quarantine',
                  ),
                ),
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
