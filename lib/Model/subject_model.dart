

class Subject {
  String? id;
  String? subjectName;
  String? courseName;

  Subject({
    this.id,
    this.subjectName,
    this.courseName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    subjectName: json["Subject_name"],
    courseName: json["Course_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Subject_name": subjectName,
    "Course_name": courseName,
  };
}
