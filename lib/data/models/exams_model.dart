import 'dart:convert';

ExamsModel examsModelFromJson(String str) =>
    ExamsModel.fromJson(json.decode(str));

class ExamsModel {
  List<Exam>? exams;

  ExamsModel({
    this.exams,
  });

  factory ExamsModel.fromJson(dynamic json) => ExamsModel(
        exams: List<Exam>.from(json.map((x) => Exam.fromJson(x))),
      );
}

class Exam {
  String id;
  String? description;

  Exam({
    this.description,
    required this.id,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
      id: json["id"],
      description: json["description"]);
}

class Person {
  String? id;
  String? name;
  String? age;
  String? gender;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
      id: json["id"],
      name: json["name"],
      age: json["age"],
      gender: json["gender"]);
}
