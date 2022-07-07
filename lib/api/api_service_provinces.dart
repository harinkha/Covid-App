import 'package:covidapp/models/ProvinceModels.dart';
import 'package:http/http.dart' as http;
import 'package:covidapp/models/CaseModels.dart';

class ApiServiceByProvince {
  Future<List<ProvinceModel>?> getCasesByProvinces() async {
    try {
      var url = Uri.parse(
          'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProvinceModel> _model = provinceFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
