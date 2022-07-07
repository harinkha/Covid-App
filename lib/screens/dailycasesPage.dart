import 'package:covidapp/models/CaseModels.dart';
import 'package:covidapp/screens/DailyCases/provinceCases.dart';
import 'package:covidapp/screens/DailyCases/summarizedCases.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:covidapp/widgets/RectangularWidget.dart';
import 'package:covidapp/widgets/newcases.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidapp/api/api_service_cases.dart';
import 'package:intl/intl.dart';

class DailyCasesPage extends StatefulWidget {
  const DailyCasesPage({Key? key}) : super(key: key);

  @override
  State<DailyCasesPage> createState() => _DailyCasesPageState();
}

class _DailyCasesPageState extends State<DailyCasesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
              bottom: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Summarized',
                    icon: Icon(Icons.summarize_rounded),
                  ),
                  Tab(
                    text: 'By Province',
                    icon: Icon(Icons.map_rounded),
                  ),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 242, 249, 255),
              elevation: 0.5,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left),
                color: Color.fromARGB(255, 12, 134, 246),
                iconSize: 40,
              ),
            ),
            body: TabBarView(
              children: [
                SummarizedTab(),
                ProvinceTab(),
              ],
            )
            // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
