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
    return Scaffold(
        body: _caseModel == null || _caseModel!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : ListView.builder(
                itemCount: _caseModel!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(_caseModel![index].newCase.toString()),
                            Text(_caseModel![index].province.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(_caseModel![index].newDeath.toString()),
                            Text(_caseModel![index]
                                .newCaseExcludeabroad
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                }));
  }
}
