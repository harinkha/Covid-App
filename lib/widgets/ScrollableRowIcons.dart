import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonIcon extends StatelessWidget {
  String path;
  String label;
  CustomButtonIcon(this.path, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        children: [
          IconButton(
            icon: Image.asset(
              path,
            ),
            iconSize: 70,
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: GoogleFonts.openSans(fontSize: 20, color: Colors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
