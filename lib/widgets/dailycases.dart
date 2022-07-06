import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyCases extends StatelessWidget {
  int cases;

  DailyCases(this.cases);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/dailycases.jpg',
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Active Cases',
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
            ),
            Align(
              alignment: AlignmentDirectional(0.9, 0),
              child: Text(
                cases.toString(),
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
