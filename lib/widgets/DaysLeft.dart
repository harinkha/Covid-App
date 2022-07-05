import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Daysleft extends StatelessWidget {
  int days;
  Daysleft(this.days);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(200))),
        width: MediaQuery.of(context).size.height / 2.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26.0),
          child: Stack(children: [
            Image.asset(
              'assets/images/covid-bg.jpg',
            ),
            Center(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "You Have",
                  style: GoogleFonts.openSans(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  days.toString(),
                  style: GoogleFonts.openSans(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Days Left",
                  style: GoogleFonts.openSans(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ])),
          ]),
        ));
  }
}
