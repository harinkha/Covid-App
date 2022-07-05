import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DurationText extends StatelessWidget {
  String text;
  DurationText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        child: Text(text,
            style: GoogleFonts.averiaSerifLibre(
                fontSize: 18, color: Color.fromARGB(255, 107, 117, 119))),
      ),
    );
  }
}
