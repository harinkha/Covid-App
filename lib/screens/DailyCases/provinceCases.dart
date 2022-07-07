import 'package:covidapp/models/CaseModels.dart';
import 'package:covidapp/widgets/BannerWidget.dart';
import 'package:covidapp/widgets/RectangularWidget.dart';
import 'package:covidapp/widgets/newcases.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidapp/api/api_service_cases.dart';
import 'package:covidapp/api/api_service_provinces.dart';
import 'package:covidapp/models/ProvinceModels.dart';
import 'package:intl/intl.dart';
import 'package:covidapp/widgets/provinceWidget.dart';

class ProvinceTab extends StatefulWidget {
  const ProvinceTab({Key? key}) : super(key: key);

  @override
  State<ProvinceTab> createState() => _ProvinceTabState();
}

// instance variables
late List<ProvinceModel>? _caseModel = []; //empty for now
//data will come from the server

class _ProvinceTabState extends State<ProvinceTab> {
  var formatter = NumberFormat();
  @override
  void initState() {
    super.initState();
    _getData();
  }

//function to get data from api service
  void _getData() async {
    _caseModel = (await ApiServiceByProvince().getCasesByProvinces())!;

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: (() async {
        await Future.delayed(Duration(seconds: 1));
        _getData();
      }),
      child: Scaffold(
          body: _caseModel == null || _caseModel!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : ListView.builder(
                  itemCount: _caseModel!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            ProvinceWidget(
                                Colors.white,
                                _caseModel![index].province,
                                formatter.format(_caseModel![index].newCase),
                                formatter.format(_caseModel![index].newDeath),
                                formatter.format(_caseModel![index].totalCase),
                                formatter.format(_caseModel![index].totalDeath))
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
