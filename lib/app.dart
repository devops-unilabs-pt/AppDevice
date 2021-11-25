import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/data/models/exams_model.dart';
import 'package:hackathon_app/pages/first_page.dart';
import 'package:hackathon_app/pages/home_page.dart';
import 'package:hackathon_app/widgets/theme.dart';

import 'data/providers/exams_provider.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  var exams = ExamsModel(exams: []);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      title: 'Hackthon',
      theme: MyTheme.buildTheme(),
      debugShowCheckedModeBanner: false,
     // home: const HomePage(title: 'HACKATHON', url: ''),
      home: const FirstPage(),
    );
  }
}
