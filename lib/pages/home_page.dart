import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_app/data/models/exams_model.dart';
import 'package:hackathon_app/models/dto.dart';

//import 'package:hackton_app/data/providers/exams_provider.dart';
import 'package:hackathon_app/models/payloadDto.dart';
import 'package:hackathon_app/pages/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';
import 'package:http/http.dart' as http;

String username = 'ara.api';
String password = '4r4B0FH';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
var examsmodellist = ExamsModel(exams: []);
List<String> exams = [];

Future<ExamsModel> getExams() async {
  final String response = await rootBundle.loadString('assets/exams_list.json');
  final data = await json.decode(response);

  examsmodellist = ExamsModel.fromJson(data);
  if (exams.isEmpty) {
    for (var element in examsmodellist.exams!) {
      exams.add(element.description.toString());
    }
  }
  return ExamsModel.fromJson(data);
}

String token =
    "eyJraWQiOiJZUE1cL2Q0OFdOWGNHSDZhdFZYdUdmMVdxRGRoTXFIZUtCbVBnTW8zQXEzcz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIzNWFlNGM2My1jNWEzLTQ4NjYtODMyZS03ZTA2MTgzODk4ZjQiLCJjb2duaXRvOmdyb3VwcyI6WyJwcmFjdGl0aW9uZXIiXSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LXdlc3QtMS5hbWF6b25hd3MuY29tXC9ldS13ZXN0LTFfSnFXZDNnc05HIiwiY2xpZW50X2lkIjoiNGEzMGN1cGc4NXBpMzdjdDFnOXMycmVsajYiLCJvcmlnaW5fanRpIjoiMDY3MTE5NDgtODhmMy00ZTY1LTgzOTktYzUxMzc3MjFiMGNjIiwiZXZlbnRfaWQiOiI4MTIyOWI1Yy04YzI3LTQ4NTEtOWM4Zi05OWM5YzQ2ZDUxYTkiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNjM3ODMxMTYwLCJleHAiOjE2Mzc5MTc1NjAsImlhdCI6MTYzNzgzMTE2MCwianRpIjoiYjQ4Y2JkODAtZDM5ZC00YTNhLTljNjUtZmRlN2NkY2QwZmE0IiwidXNlcm5hbWUiOiJhcGlfZmhpcl9hcHAifQ.oyBF2_hPh3paVOH-Xk-TM9qNtcWjmupftKkAOx13XHQ56lXCwBDOs3HmwrBUBfYccj_56eOZQFFAZZE9A-g152beqNVKlInbGIsKgP1ZPrJnjFWmrwr6KIK-rINaBymhVTCFbFyRNERmGU6O6DMvviZQatAJKAzBDlQGBBmYnNHYfVLq8T80P1Nj_BPpZ65ejTzGtg7lTH-VKPH2UEi7xXQaPCJrdx8h9SNUqRl6WJxmi5UDap-JRwWTrapvP3MSlCBRZBBxSQcE9GOJdHG7tf_IH5UU2VDtaQUis8OqqOUU6JhpSbQQXvrd0N_1jzc3HnMOYtuFhaUDvTXGhbVqBg";

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.title,
      required this.url,
      required this.name,
      required this.age,
      required this.id,
      required this.gender})
      : super(key: key);
  final String url;
  final String title;
  final String name;
  final String age;
  final String gender;
  final String id;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ExamsModel> examsModel;
  Dto dto = Dto(
      subject: null,
      valueString: '',
      effectiveDateTime: null,
      code: null,
      status: '',
      resourceType: '');
  Subject subject = Subject(reference: '');
  List<Coding> codingList = [];
  Code code = Code(coding: null);
  Coding coding = Coding(system: null, code: null, display: null);
  String examCode = "";
  String? dropdownvalue;
  String? result;
  TextEditingController? _outputController;
  TextEditingController? _resultController;
  String url = '';
  String? resulttextfield;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _outputController = TextEditingController();
    url = widget.url;
    examsModel = getExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.red),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              url,
                              widget.name,
                              widget.age,
                              widget.gender,
                              widget.id,
                            )));
              },
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<ExamsModel>(
            future: examsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: double.infinity,
                 // height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          bottom: 0.0,
                          child: SvgPicture.asset(
                            "assets/background.svg",
                            fit: BoxFit.cover,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 27,
                                      ),
                                      Text(
                                        " " + widget.name,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.cake_rounded,
                                          size: 27,
                                        ),
                                        Text(
                                          " " + widget.age,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.male,
                                          size: 20,
                                        ),
                                        const Icon(
                                          Icons.female,
                                          size: 20,
                                        ),
                                        Text(
                                          " " + widget.gender,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                            child: const Text(
                              "Exames disponiveis:",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 20, 25, 20),
                              child: DropdownButton(
                                  value: dropdownvalue,
                                  hint: const Text("Escolha um exame"),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: exams.map((String brands) {
                                    return DropdownMenuItem(
                                        value: brands,
                                        child: Text(brands,
                                            style:
                                                const TextStyle(fontSize: 13)));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  })),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: Text(
                                    "Resultado",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextField(
                                    controller: _resultController,
                                    onSubmitted: (value) {
                                      setState(() {
                                        resulttextfield = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Escreva aqui o seu resultado',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 125,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              spreadRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: const Offset(0, 2),
                                              blurRadius: 9,
                                            )
                                          ]),
                                      child: TextButton(
                                          onPressed: () {
                                            _sendData();
                                          },
                                          child: const Text(
                                            "Enviar dados",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }

  void _resetData() {
    setState(() {
      coding.code = null;
      coding.display = null;
      coding.system = null;
      codingList.clear();
      code.coding = null;
      subject.reference = null;
      dto.resourceType = null;
      dto.status = null;
      dto.code = null;
      dto.subject = null;
      dto.effectiveDateTime = null;
      dto.valueString = null;
    });
  }

  Future<void> _sendData() async {
    getExamcode();
    setState(() {
      coding.code = examCode;
      coding.display = dropdownvalue.toString();
      coding.system = "http://loinc.org";
      codingList.add(coding);
      code.coding = codingList;
      subject.reference = "Patient/${widget.id}";
      DateTime dateTime = DateTime.now();
      var date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
      dto.resourceType = "Observation";
      dto.status = "final";
      dto.code = code;
      dto.subject = subject;

      dto.effectiveDateTime = date;
      dto.valueString = resulttextfield;
    });
    final json = jsonEncode({
      'resourceType': '${dto.resourceType}',
      'status': '${dto.status}',
      'code': dto.code,
      'subject': dto.subject,
      'effectiveDateTime': '${dto.effectiveDateTime}',
      'valueString': '${dto.valueString}',
    });
    if (url == '') {
      String uri =
          "https://h3s2x3h863.execute-api.eu-west-1.amazonaws.com/dev/Observation";
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptEncodingHeader: "*/*",
        "x-api-key": 'URcRSfYIoKhc85ayXyYabaO1Da8sJa73snCqku80',
        HttpHeaders.authorizationHeader: token,
      };

      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: json);
print(response.body);

    } else {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
      };

      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: json);
    }
    _resetData();
    showDialog(builder: (context) => confimationDialog(), context: context);

  }

  getExamcode() {
    for (var element in examsmodellist.exams!) {
      if (element.description == dropdownvalue.toString()) {
        setState(() {
          examCode = element.id;
        });
      }
    }
  }



  Widget confimationDialog() {
    return Dialog(
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 80,
        child: const Text(
          "Dados enviados",
          style: TextStyle(color: Colors.green, fontSize: 17),
        ),
      ),
    );
  }
}
