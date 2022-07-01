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
            Image.network(
              'https://img.freepik.com/free-photo/covid-19-corona-virus-with-spike-glycoprotein-are-floating-air-blue-color-background-3d-rendering_18981-654.jpg?w=2000',
            ),
            Center(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You Have",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  days.toString(),
                  style:
                      GoogleFonts.openSans(fontSize: 40, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Days Left",
                  style:
                      GoogleFonts.openSans(fontSize: 30, color: Colors.white),
                ),
              ),
            ])),
          ]),
        ));
  }
}
