import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DurationTime extends StatelessWidget {
  String dateOrtime;
  DurationTime(this.dateOrtime);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(dateOrtime,
              style: GoogleFonts.averiaSerifLibre(
                  fontSize: 18, color: Color.fromARGB(255, 107, 117, 119))),
        ),
      ),
    );
  }
}
