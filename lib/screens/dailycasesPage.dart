import 'package:covidapp/models/CaseModels.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:covidapp/widgets/RectangularWidget.dart';
import 'package:covidapp/widgets/newcases.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidapp/api/api_service.dart';

class DailyCasesPage extends StatefulWidget {
  const DailyCasesPage({Key? key}) : super(key: key);

  @override
  State<DailyCasesPage> createState() => _DailyCasesPageState();
}

// instance variables
late List<CaseModel>? _caseModel = []; //empty for now
//data will come from the server

class _DailyCasesPageState extends State<DailyCasesPage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

//function to get data from api service
  void _getData() async {
    _caseModel = (await ApiService().getCases())!;

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

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
            NewCases('assets/images/covid-bg.png', 'New Cases',
                _caseModel![0].newCase, (() {})),
            Row(
              children: [
                RectangularWidget(Colors.white,
                    _caseModel![0].totalCase.toString(), 'Total Infections'),
                RectangularWidget(Colors.white,
                    _caseModel![0].totalDeath.toString(), 'Total Deaths'),
              ],
            ),
            Row(
              children: [
                RectangularWidget(Colors.white,
                    _caseModel![0].newDeath.toString(), 'New Deaths'),
                RectangularWidget(Colors.white,
                    _caseModel![0].newRecovered.toString(), 'New Recovered'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NewCases('assets/images/recovery.jpg', 'Total Recovered',
                  _caseModel![0].totalRecovered, (() {})),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
