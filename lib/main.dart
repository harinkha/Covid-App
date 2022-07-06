import 'package:covidapp/widgets/DaysLeft.dart';
import 'package:covidapp/widgets/ScrollableRowIcons.dart';
import 'package:covidapp/widgets/dailycases.dart';
import 'package:covidapp/widgets/duration.dart';
import 'package:covidapp/widgets/durationText.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        appBar: AppBar(
          title: Text(
            "Home",
            style: GoogleFonts.archivoBlack(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 242, 249, 255),
          elevation: 0,
        ),
        body: Column(
          children: [
            Center(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: DailyCases(125),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      CustomButtonIcon('assets/images/news-report.png', 'News'),
                      CustomButtonIcon('assets/images/flask.png', 'Labs'),
                      CustomButtonIcon(
                          'assets/images/information.png', 'Information'),
                      CustomButtonIcon(
                          'assets/images/medicine.png', 'Reminder'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: bannerWidget(
                      'assets/images/covid-bg.png', 'Enter Quarantine'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: bannerWidget(
                      'assets/images/covid-bg.png', 'Detailed Daily Cases'),
                ),
              ],
            ))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
