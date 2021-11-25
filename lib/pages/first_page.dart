import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_app/data/models/exams_model.dart';
import 'package:hackathon_app/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

import 'form_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var json;
  Exam? exam;
  Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "HACKATHON",
            style: TextStyle(color: Colors.red),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: Stack(children: <Widget>[
          Positioned(
              bottom: 0.0,
              child: SvgPicture.asset(
                "assets/background.svg",
                fit: BoxFit.cover,
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ler QRCode",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 130,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          _scan();
                        },
                        child: const Icon(Icons.qr_code_2,
                            color: Colors.black, size: 80),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      json = jsonDecode(barcode);
      person = Person.fromJson(json);
      print(person!.name.toString());
      String? name = person!.name;
      String? age = person!.age;
      String? gender = person!.gender;
      String? id = person!.id;
      setState(() {});
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    title: 'HACKATHON',
                    url: "",
                    name: name!,
                    age: age!,
                    gender: gender!,
                    id: id!,
                  ))); // dto.code = _outputController!.text;
    }
  }
}
