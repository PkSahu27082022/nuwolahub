import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';
import 'package:nuvolahub/Model/question_model.dart';
import 'package:nuvolahub/Model/question_option_model.dart';
import 'package:nuvolahub/View/category_view.dart';
import 'package:provider/provider.dart';

class QuizViewModel extends ChangeNotifier {
  static QuizViewModel of(BuildContext context) =>
      Provider.of<QuizViewModel>(context, listen: false);

  callInit() {
    getQuestion();
    // remainingTime=10;
    // startTimer();
    notifyListeners();
  }

  List<Question> _question = [];
  List<Question> get question => _question;
  set question(List<Question> list) {
    _question = list;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Question? _currentQuestion;
  Question? get currentQuestion => _currentQuestion;
  set currentQuestion(Question? model) {
    _currentQuestion = model;
    notifyListeners();
  }

  List<QuestionOption> _questionOption = [];
  List<QuestionOption> get questionOption => _questionOption;
  set questionOption(List<QuestionOption> list) {
    _questionOption = list;
    notifyListeners();
  }

  int _remainingTime = 10;
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
      } else {
        Navigator.pushReplacement(
            NavigationService.context!,
            MaterialPageRoute(
              builder: (context) => const CategoryView(),
            ));
        _timer.cancel();
      }
    });
  }

  final ApiCall _apiCall = ApiCall();

  Future<void> getQuestion() async {
    try {
      PD.show(message: "Loading questions..");
      await _apiCall
          .call(url: 'QuestionsAPI.php', apiCallType: ApiCallType.get())
          .then((data) async {
        if (data['records'] != null) {
          _question = (data['records'] as List)
              .map((e) => Question.fromJson(e))
              .toList();
          currentQuestion = _question.first;
          await getQuestionOption(showLoading: false);
        }
      });
      PD.hide();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getQuestionOption({bool showLoading=true}) async {
    try {
      if(showLoading){
        PD.show(message: "Please wait..");
      }
      await _apiCall
          .call(
              url: 'OptionsAPI.php?QuesId=${currentQuestion?.id}',
              apiCallType: ApiCallType.get())
          .then((data) {
        if (data['records'] != null) {
          _questionOption = (data['records'] as List)
              .map((e) => QuestionOption.fromJson(e))
              .toList();
          //_currentQuestionOption = _questionOption.first;
        }
      });
      if(showLoading){
        PD.hide();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  void getNextQuestion() {
    if (_currentIndex < _question.length - 1) {
      _currentIndex++;
      _currentQuestion = _question[_currentIndex];
      getQuestionOption();
      // _currentQuestionOption=questionOption.firstWhere((e) => e.id==_currentQuestion?.id);
    }
    notifyListeners();
  }

  void getPreviousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _currentQuestion = _question[_currentIndex];
      getQuestionOption();
      // _currentQuestionOption=questionOption.firstWhere((e) => e.id==_currentQuestion?.id);
    }
    notifyListeners();
  }
}
