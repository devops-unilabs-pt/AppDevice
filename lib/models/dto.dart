// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';



String dtoToJson(Dto data) => json.encode(data.toJson());

class Dto {
  String? resourceType;
  String? status;
  Code? code;
  Subject? subject;
  String? effectiveDateTime;
  String? valueString;

  Dto({
    required this.resourceType,
    required this.status,
    required this.code,
    required this.subject,
    required this.effectiveDateTime,
    required this.valueString,
  });

  Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "status": status,
        "code": code!.toJson(),
        "subject": subject!.toJson(),
        "effectiveDateTime": effectiveDateTime,
        "valueString": valueString,
      };
}

class Code {
  Code({
    required this.coding,
  });

  List<Coding>? coding;

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        coding:
            List<Coding>.from(json["coding"].map((x) => Coding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coding": List<dynamic>.from(coding!.map((x) => x.toJson())),
      };
}

class Coding {
  Coding({
    required this.system,
    required this.code,
    required this.display,
  });

  String? system;
  String? code;
  String? display;

  factory Coding.fromJson(Map<String, dynamic> json) => Coding(
        system: json["system"],
        code: json["code"],
        display: json["display"],
      );

  Map<String, dynamic> toJson() => {
        "system": system,
        "code": code,
        "display": display,
      };
}

class Subject {
  Subject({
    required this.reference,
  });

  String? reference;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
      };
}
