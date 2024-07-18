import 'dart:convert';

class StudentResult {
  String? id;
  String? studentName;
  String? paperName;
  String? markObtained;
  String? maxMark;
  String? percentage;
  String? status;

  StudentResult({
    this.id,
    this.studentName,
    this.paperName,
    this.markObtained,
    this.maxMark,
    this.percentage,
    this.status,
  });

  factory StudentResult.fromRawJson(String str) => StudentResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentResult.fromJson(Map<String, dynamic> json) => StudentResult(
    id: json["id"],
    studentName: json["Student_name"],
    paperName: json["Paper_name"],
    markObtained: json["Mark_obtained"],
    maxMark: json["Max_Mark"],
    percentage: json["Percentage"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Student_name": studentName,
    "Paper_name": paperName,
    "Mark_obtained": markObtained,
    "Max_Mark": maxMark,
    "Percentage": percentage,
    "Status": status,
  };
}
