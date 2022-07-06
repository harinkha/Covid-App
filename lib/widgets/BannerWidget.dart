import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bannerWidget extends StatelessWidget {
  String label;
  String path;
  bannerWidget(this.path, this.label);

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
        child: GestureDetector(
          onTap: () {
            print('object');
          },
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    path,
                    width: double.infinity,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
