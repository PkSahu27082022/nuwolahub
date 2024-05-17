
class Course {
  String? id;
  String? paperName;
  String? courseName;
  String? duration;
  String? noOfQuestion;
  String? totalMarks;

  Course({
    this.id,
    this.paperName,
    this.courseName,
    this.duration,
    this.noOfQuestion,
    this.totalMarks,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    paperName: json["paper_name"],
    courseName: json["Course_name"],
    duration: json["Duration"],
    noOfQuestion: json["NoOfQuestion"],
    totalMarks: json["Total_Marks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paper_name": paperName,
    "Course_name": courseName,
    "Duration": duration,
    "NoOfQuestion": noOfQuestion,
    "Total_Marks": totalMarks,
  };
}
