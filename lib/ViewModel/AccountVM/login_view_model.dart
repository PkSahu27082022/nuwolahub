import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/alert.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/AppManager/Helper/snack_bar.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';
import 'package:nuvolahub/Model/user_model.dart';
import 'package:nuvolahub/View/category_view.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {

  static LoginViewModel of(BuildContext context) =>
      Provider.of<LoginViewModel>(context, listen: false);

  final TextEditingController mobileC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  set isPasswordVisible(bool visibility) {
    _isPasswordVisible = visibility;
    notifyListeners();
  }

  clear() {
    mobileC.clear();
    passC.clear();
    _isPasswordVisible = false;
    notifyListeners();
  }

  User _user=User();
  User get user=>_user;
  set user(User model){
    _user=model;
    notifyListeners();
  }


  final ApiCall _apiCall = ApiCall();

  Future<void> login() async {
    try {
      PD.show(message: "Please wait");
      await _apiCall.call(
              url: "loginAPI.php?password=${passC.text.trim()}&mobile=${mobileC.text.trim()}",
              apiCallType: ApiCallType.get())
          .then((data) async {
        if (data["status"] == true) {
          _user=User.fromJson(data["data"]);
          await CategoryViewModel.of(NavigationService.context!).getNewsDetails();
          await CategoryViewModel.of(NavigationService.context!).getCategory();
          Alert.show(data["message"]);
          await Navigator.pushReplacement(NavigationService.context!,
              MaterialPageRoute(builder: (context) => const CategoryView()));
        } else {
          AppSnackBar.show(message: data["message"]);
        }
      });
      PD.hide();
    } catch (e) {
      PD.hide();
    }
    notifyListeners();
  }
}
