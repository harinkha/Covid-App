import 'package:http/http.dart' as http;
import 'package:covidapp/models/CaseModels.dart';

class ApiService {
  Future<List<CaseModel>?> getCases() async {
    try {
      var url =
          Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<CaseModel> _model = caseModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
