import 'dart:convert';

class Question {
  String? id;
  String? subjectName;
  String? eQuestion;
  String? hQuestion;
  dynamic eQuesSolution;
  dynamic hQuesSolution;

  Question({
    this.id,
    this.subjectName,
    this.eQuestion,
    this.hQuestion,
    this.eQuesSolution,
    this.hQuesSolution,
  });

  factory Question.fromRawJson(String str) => Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    subjectName: json["Subject_name"],
    eQuestion: json["EQuestion"],
    hQuestion: json["HQuestion"],
    eQuesSolution: json["EQuesSolution"],
    hQuesSolution: json["HQuesSolution"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Subject_name": subjectName,
    "EQuestion": eQuestion,
    "HQuestion": hQuestion,
    "EQuesSolution": eQuesSolution,
    "HQuesSolution": hQuesSolution,
  };
}
