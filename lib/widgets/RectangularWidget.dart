import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangularWidget extends StatelessWidget {
  String number;
  String bottom;
  Color c;

  RectangularWidget(this.c, this.number, this.bottom);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: c,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset.infinite),
          ],
        ),
        width: MediaQuery.of(context).size.width / 2.5,
        height: 130,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: GoogleFonts.kameron(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 35),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  bottom,
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
