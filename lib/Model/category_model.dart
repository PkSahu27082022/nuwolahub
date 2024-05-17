class CategoryRecord {
  String? id;
  String? courseName;
  String? imageUrl;
  int? noOfPaper;

  CategoryRecord({
    this.id,
    this.courseName,
    this.imageUrl,
    this.noOfPaper
  });

  factory CategoryRecord.fromJson(Map<String, dynamic> json) => CategoryRecord(
    id: json["id"],
    courseName: json["course_name"],
      imageUrl:json["image"],
    noOfPaper: json["noofpaper"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": courseName,
    "image":imageUrl,
    "noofpaper":noOfPaper
  };
}