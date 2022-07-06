import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:covidapp/widgets/RectangularWidget.dart';
import 'package:covidapp/widgets/newcases.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyCasesPage extends StatelessWidget {
  const DailyCasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 249, 255),
        appBar: AppBar(
          title: Text(
            "Today",
            style: GoogleFonts.archivoBlack(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 242, 249, 255),
          elevation: 0.5,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_arrow_left),
            color: Color.fromARGB(255, 12, 134, 246),
            iconSize: 40,
          ),
        ),
        body: ListView(
          children: [
            NewCases('assets/images/covid-bg.png', 'New Cases', 123, (() {})),
            Row(
              children: [
                RectangularWidget(Colors.white, '123', 'Total Infections'),
                RectangularWidget(Colors.white, '123', 'Total Deaths'),
              ],
            ),
            Row(
              children: [
                RectangularWidget(Colors.white, '123', 'New Deaths'),
                RectangularWidget(Colors.white, '123', 'New Recovered'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NewCases('assets/images/recovery.jpg', 'Total Recovered',
                  123, (() {})),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
