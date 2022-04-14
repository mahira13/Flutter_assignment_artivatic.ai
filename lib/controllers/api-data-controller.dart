import 'dart:convert';
import 'package:assignment_artivatic/models/api-data-model.dart';
import 'package:http/http.dart' as http;
class ApiDataController {

  Future<ApiDataModel> getDataList() async {
  
    var response = await http.get(Uri.parse(
      "https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf"),  //api
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ApiDataModel.fromJson(jsonDecode(response.body));  // return data from model class
    }
     else {
      throw Exception('Error in API');
    }
  }
}
