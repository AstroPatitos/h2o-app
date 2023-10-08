import 'dart:convert';

import 'package:h2o_app/src/helpers/printers.dart';
import 'package:http/http.dart' as http;
import 'package:h2o_app/src/services/environment.dart' as environment;

class LocationService {
  Future<List<Map<String, dynamic>>> getLocations() async {
    printWarning('debug: ');
    try {
      final http.Response response = await http.get(
          // Uri.parse('http://127.0.01:3001/api/water-body'),
          // Uri.parse('http://10.0.2.2:3000/'),
          Uri.parse(
              'https://6d08-186-121-254-20.ngrok-free.app/api/water-body'),
          headers: <String, String>{
            'ngrok-skip-browser-warning': '69420',
          }
          // Uri.parse('https://google.com/'),
          );
      printWarning(response.body);
      dynamic decodedJson = jsonDecode(response.body);
      printWarning('decodedJson: ');
      printWarning(decodedJson);
    } catch (error) {
      printWarning('error: ');
      printWarning(error);
    }
    return [];
  }
}
