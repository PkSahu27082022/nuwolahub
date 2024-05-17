import 'package:flutter/cupertino.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/alert.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';
import 'package:nuvolahub/Model/course_model.dart';
import 'package:nuvolahub/Model/subject_model.dart';
import 'package:nuvolahub/View/Widget/subject_bottomsheet.dart';
import 'package:provider/provider.dart';

class PaperViewModel extends ChangeNotifier{
  
  static PaperViewModel of(BuildContext context)=>Provider.of<PaperViewModel>(context,listen: false);

  bool _isReadInstruction=false;
  bool get isReadInstruction=>_isReadInstruction;
  set isReadInstruction(bool val){
    _isReadInstruction=val;
    notifyListeners();
  }


  List<Subject> _subject=[];
  List<Subject> get subject=>_subject;
  set subject(List<Subject> list){
    _subject=list;
    notifyListeners();
  }
  
  final ApiCall _apiCall=ApiCall();
  
  Future<void> getSubject({Course? course}) async{
    try{
      PD.show(message: "Please wait..");

     await _apiCall.call(url: "SubjectAPI.php?courseid=${course?.courseName}",
         apiCallType: ApiCallType.get()).then((data) async {
       if((data["records"] as List).isNotEmpty){
        _subject= (data["records"] as List).map((e) => Subject.fromJson(e)).toList();
         PD.hide();
        await SubjectBottomSheet.show(NavigationService.context!,course: course);
       }else{
         Alert.show(data["message"]);
       }

     });
    }catch(e){
      PD.hide();
    }
    notifyListeners();
  }
}