
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hackathon_app/data/models/exams_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


String username = 'ara.api';
String password = '4r4B0FH';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

/*Future<ExamsModel> getExams() async {
String uri = "https://ara-testes.unilabs.pt/api/v1/auth";

var examsJson = await http.get(Uri.parse(uri + "/covid/brands"),
    headers: <String, String>{"authorization": basicAuth});

  var journeyJson = jsonDecode(examsJson.body);
  return ExamsModel.fromJson(journeyJson);
}*/
