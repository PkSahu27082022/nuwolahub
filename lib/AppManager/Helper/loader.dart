import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';

late BuildContext currentContext;


class PD{


  static show({
    required String message,
  }) async{
    _showProgressDialogue(message);
  }



  static bool hide() {
    try{
      Navigator.pop(currentContext);
      return true;
    }
    catch (e){
      return false;
    }
  }


}





_showProgressDialogue(message,) async{
  BuildContext? context=NavigationService.context;
  return    context==null? null:showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext dialogContext) {
      currentContext= dialogContext;
      return ProgressDialogueWidget(message: message);
    },
  );
}



class ProgressDialogueWidget extends StatelessWidget {
  final String message;
  const ProgressDialogueWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return PopScope(
      canPop:false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.black12,
            child:     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              height: 150,
                              child: Lottie.asset("asset/json/loading.json")),
                        ),
                        Text(message,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white
                            )
                        ),
                        // factsDialogue(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
