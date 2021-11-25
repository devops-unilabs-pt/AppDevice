import 'package:flutter/material.dart';
import 'package:hackathon_app/data/models/exams_model.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'data/providers/exams_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App());
}
