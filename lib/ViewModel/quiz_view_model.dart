import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/alert.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/AppManager/Helper/snack_bar.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';
import 'package:nuvolahub/Model/question_model.dart';
import 'package:nuvolahub/Model/question_option_model.dart';
import 'package:nuvolahub/Model/student_result_model.dart';
import 'package:nuvolahub/View/category_view.dart';
import 'package:nuvolahub/View/result_view.dart';
import 'package:nuvolahub/ViewModel/AccountVM/login_view_model.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:provider/provider.dart';

class QuizViewModel extends ChangeNotifier {
  static QuizViewModel of(BuildContext context) =>
      Provider.of<QuizViewModel>(context, listen: false);

  callInit() {
    getQuestion();
    remainingTime = int.parse(CategoryViewModel.of(NavigationService.context!)
            .courseList
            .first
            .duration
            .toString()) *
        60;
    startTimer();
    notifyListeners();
  }

  List<Question> _questions = [];
  List<Question> get questions => _questions;
  set questions(List<Question> list) {
    _questions = list;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Question? get currentQuestion =>
      questions.isNotEmpty ? questions[currentIndex] : null;

  List<QuestionOption> _questionOptions = [];
  List<QuestionOption> get questionOptions => _questionOptions;
  set questionOptions(List<QuestionOption> list) {
    _questionOptions = list;
    notifyListeners();
  }

  List<StudentResult> _result=[];
  List<StudentResult> get result => _result;
  // set result(StudentResult? model) {
  //   _result = model;
  //   notifyListeners();
  // }

  final Map<int, QuestionOption?> _selectedOptions = {};
  Map<int, QuestionOption?> get selectedOptions => _selectedOptions;

  void addSelectedOption(int questionId, QuestionOption? option) {
    _selectedOptions[questionId] = option;
    notifyListeners();
  }

  QuestionOption? getSelectedOption(int questionId) {
    return _selectedOptions[questionId];
  }

  int _remainingTime = int.parse(
          CategoryViewModel.of(NavigationService.context!)
              .courseList
              .first
              .duration
              .toString()) *
      60;
  int get remainingTime => _remainingTime;
  set remainingTime(int val) {
    _remainingTime = val;
    notifyListeners();
  }

  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        remainingTime--;
        updateDisplayTime();
      } else {
        showResult();
        // Navigator.pushReplacement(
        //   NavigationService.context!,
        //   MaterialPageRoute(
        //     builder: (context) => const CategoryView(),
        //   ),
        // );
        _timer.cancel();
      }
    });
  }

  void paperCancel() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(
      NavigationService.context!,
      MaterialPageRoute(
        builder: (context) => const CategoryView(),
      ),
      (Route<dynamic> route) =>
          false, // This ensures all previous routes are removed
    );
    notifyListeners();
  }

  String updateDisplayTime() {
    int hours = _remainingTime ~/ 3600;
    int minutes = (_remainingTime % 3600) ~/ 60;
    //int seconds = _remainingTime % 60;
    return '$hours h: $minutes min';
  }

  final ApiCall _apiCall = ApiCall();

  Future<void> getQuestion() async {
    try {
      PD.show(message: "Loading questions..");
      await _apiCall
          .call(url: 'QuestionsAPI.php', apiCallType: ApiCallType.get())
          .then((data) async {
        if (data['records'] != null) {
          _questions = (data['records'] as List)
              .map((e) => Question.fromJson(e))
              .toList();
          currentIndex = 0;
          await getQuestionOptions(showLoading: false);
        }
      });
      PD.hide();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getQuestionOptions({bool showLoading = true}) async {
    try {
      if (showLoading) {
        PD.show(message: "Please wait..");
      }
      await _apiCall
          .call(
              url: 'OptionsAPI.php?QuesId=${currentQuestion?.id}',
              apiCallType: ApiCallType.get())
          .then((data) {
        if (data['records'] != null) {
          _questionOptions = (data['records'] as List)
              .map((e) => QuestionOption.fromJson(e))
              .toList();
        }
      });
      if (showLoading) {
        PD.hide();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  void moveToNextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      getQuestionOptions();
    }
    notifyListeners();
  }

  void moveToPreviousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      getQuestionOptions();
    }
    notifyListeners();
  }

  bool isQuizComplete() {
    return _questions
        .every((question) => _selectedOptions.containsKey(question.id));
  }

  Future<void> saveAnswerOfQuestion({required QuestionOption option}) async {
    try {
      PD.show(message: "Please wait..");
      await _apiCall
          .call(
              url: 'SavePaperAPI.php',
              apiCallType: ApiCallType.post(body: {
                "StdId": LoginViewModel.of(NavigationService.context!).user.id,
                "QueId": option.questionId,
                "AnsId": option.id,
                "PapId": CategoryViewModel.of(NavigationService.context!)
                    .courseList
                    .first
                    .id,
                "Status": "1"
              }))
          .then((data) {
        if (data["status"] == true) {
          PD.hide();
        }
      });
    } catch (e) {
      // PD.hide();
      if (kDebugMode) {
        print(e);
      }
    }
  }

 String? id= LoginViewModel.of(NavigationService.context!).user.id;
  String? paperId=CategoryViewModel.of(NavigationService.context!)
      .courseList
      .first
      .id;

  Future<void> showResult() async {
    try {
     // PD.show(message: "Please wait...");
      await _apiCall
          .call(
              url: "Student_ResultAPI.php?Std_ID=$id&Paper_Id=$paperId",
              apiCallType: ApiCallType.get())
          .then((data) {
        if (data["status"] == true) {
          PD.hide();
          _result = (data["records"] as List)
              .map((e) => StudentResult.fromJson(e))
              .toList();
          Navigator.pushAndRemoveUntil(
              NavigationService.context!,
              MaterialPageRoute(
                  builder: (context) => ResultView(studentResultList: _result)),
              (Route<dynamic> rote) => false);
        }else{
         // PD.hide();
          AppSnackBar.show(message: data["message"]);
        }
      });
    } catch (e) {
     // PD.hide();
      if (kDebugMode) {
        print(e);
      }
    }
  }



  Future<void> finalSubmit() async {
    try {
      PD.show(message: "Please wait...");
      await _apiCall
          .call(
          url: "FinalSubmitAPI.php?Std_ID=$id&Paper_Id=$paperId&course_id=12",
          apiCallType: ApiCallType.get())
          .then((data) {
        if (data["status"] == true) {
          showResult();
        }else{
          PD.hide();
          AppSnackBar.show(message: data["message"]);
        }
      });
    } catch (e) {
      PD.hide();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // int calculateScore() {
  //   int score = 0;
  //   for (var question in _questions) {
  //     if (_selectedOptions[question.id]?.isCorrect ?? false) {
  //       score++;
  //     }
  //   }
  //   return score;
  // }
}
