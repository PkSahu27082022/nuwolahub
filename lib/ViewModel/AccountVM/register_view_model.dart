import 'package:flutter/cupertino.dart';
import 'package:nuvolahub/AppManager/Api/api_call.dart';
import 'package:nuvolahub/AppManager/Helper/alert.dart';
import 'package:nuvolahub/AppManager/Helper/loader.dart';
import 'package:nuvolahub/AppManager/Helper/snack_bar.dart';
import 'package:provider/provider.dart';

class RegisterViewModel extends ChangeNotifier {
  static RegisterViewModel of(BuildContext context) =>
      Provider.of<RegisterViewModel>(context, listen: false);

  final TextEditingController userNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController mobileC = TextEditingController();

  clear() {
    userNameC.clear();
    emailC.clear();
    passC.clear();
    mobileC.clear();
    notifyListeners();
  }

  final _apiCall = ApiCall();

  Future<void> register() async {
    try {
      PD.show(message: 'Please wait');
      await _apiCall.call(
          url: "singupAPI.php",
          apiCallType: ApiCallType.post(body: {
            "name": userNameC.text,
            "password": passC.text,
            "email": emailC.text,
            "mobileNo": mobileC.text
          })).then((data) {
        if(data["status"]==true){
          Alert.show(data["message"]);
        }else{
          AppSnackBar.show(message: data["message"]);
        }
      });
      PD.hide();
    } catch (e) {
      PD.hide();
    }
  }
}
