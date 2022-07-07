import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProvinceWidget extends StatelessWidget {
  String province;
  String newCases;
  String newDeaths;
  String totalCases;
  String totalDeaths;
  Color c;

  ProvinceWidget(this.c, this.province, this.newCases, this.newDeaths,
      this.totalCases, this.totalDeaths);

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
        // width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 12,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                province,
                style: GoogleFonts.kameron(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'New Cases: ' + newCases,
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'New Deaths: ' + newDeaths,
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Total Cases: ' + totalCases,
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Total Deaths: ' + totalDeaths,
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
