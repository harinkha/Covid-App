import 'package:covidapp/models/CaseModels.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:covidapp/widgets/RectangularWidget.dart';
import 'package:covidapp/widgets/newcases.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidapp/api/api_service_cases.dart';
import 'package:intl/intl.dart';

class SummarizedTab extends StatefulWidget {
  const SummarizedTab({Key? key}) : super(key: key);

  @override
  State<SummarizedTab> createState() => _SummarizedTabState();
}

// instance variables
late List<CaseModel>? _caseModel = []; //empty for now
//data will come from the server

class _SummarizedTabState extends State<SummarizedTab> {
  var formatter = NumberFormat();
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
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        _getData();
      },
      child: Scaffold(
        body: _caseModel == null || _caseModel!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  NewCases('assets/images/covid-bg.png', 'New Cases',
                      formatter.format(_caseModel![0].newCase), (() {})),
                  Row(
                    children: [
                      RectangularWidget(
                          Colors.white,
                          formatter.format(_caseModel![0].totalCase),
                          'Total Infections'),
                      RectangularWidget(
                          Colors.white,
                          formatter.format(_caseModel![0].totalDeath),
                          'Total Deaths'),
                    ],
                  ),
                  Row(
                    children: [
                      RectangularWidget(Colors.white,
                          _caseModel![0].newDeath.toString(), 'New Deaths'),
                      RectangularWidget(
                          Colors.white,
                          formatter.format(_caseModel![0].newRecovered),
                          'New Recovered'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: NewCases(
                        'assets/images/recovery.jpg',
                        'Total Recovered',
                        formatter.format(_caseModel![0].totalRecovered),
                        (() {})),
                  ),
                ],
              ),
      ),
    );
  }
}
