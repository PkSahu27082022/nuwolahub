import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/Model/category_model.dart';
import 'package:nuvolahub/Model/course_model.dart';
import 'package:nuvolahub/Model/news_model.dart';
import 'package:provider/provider.dart';

class CategoryViewModel extends ChangeNotifier {

  static CategoryViewModel of(BuildContext context) =>
      Provider.of<CategoryViewModel>(context, listen: false);


  final ApiCall _apiCall = ApiCall();

  List<CategoryRecord> _categoryList = [];
  List<CategoryRecord> get categoryList => _categoryList;
  set categoryList(List<CategoryRecord> list) {
    _categoryList = list;
    notifyListeners();
  }

  List<News> _newsList=[];
  List<News> get newsList=>_newsList;
  set newsList( List<News> list){
    _newsList=list;
    notifyListeners();
  }

  List<Course> _courseList=[];
  List<Course> get courseList=>_courseList;
  set courseList(List<Course> list){
    _courseList=list;
    notifyListeners();
  }

  Future<void> getCategory() async {
    try {
      await _apiCall.call(url: "categoryAPI.php", apiCallType: ApiCallType.get()).then((data) {
        _categoryList = (data["records"] as List).map((e) => CategoryRecord.fromJson(e)).toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  // Future<void> getNews() async {
  //   try {
  //     await _apiCall.call(url: "newsAPI.php", apiCallType: ApiCallType.get()).then((data) {
  //       _newsList = (data["records"] as List).map((e) => News.fromJson(e)).toList();
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> getNewsDetails() async {
    try {
      await _apiCall.call(url: "GetNewsAPI.php?id=1", apiCallType: ApiCallType.get()).then((data) {
        _newsList = (data["records"] as List).map((e) => News.fromJson(e)).toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }



  Future<void> getCourse({required String courseId}) async {
    try {
      PD.show(message: "Loading...");
      _courseList.clear();
      await _apiCall.call(url: "GetPaperAPI.php?courseid=$courseId", apiCallType: ApiCallType.get()).then((data) {
        _courseList = (data["records"] as List).map((e) => Course.fromJson(e)).toList();
      });
      PD.hide();
    } catch (e) {
      PD.hide();
    }
    notifyListeners();
  }
}
