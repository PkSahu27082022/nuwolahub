import 'dart:convert';

class QuestionOption {
  String? id;
  String? questionId;
  String? optionTextEng;
  String? optionTextHindi;
  String? isCorrect;
  String? createdBy;

  QuestionOption({
    this.id,
    this.questionId,
    this.optionTextEng,
    this.optionTextHindi,
    this.isCorrect,
    this.createdBy,
  });

  factory QuestionOption.fromRawJson(String str) => QuestionOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
    id: json["id"],
    questionId: json["QuestionId"],
    optionTextEng: json["Option_Text_Eng"],
    optionTextHindi: json["Option_Text_Hindi"],
    isCorrect: json["IsCorrect"],
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "QuestionId": questionId,
    "Option_Text_Eng": optionTextEng,
    "Option_Text_Hindi": optionTextHindi,
    "IsCorrect": isCorrect,
    "CreatedBy": createdBy,
  };
}
