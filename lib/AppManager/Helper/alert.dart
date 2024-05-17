




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Alert {

  static void show(message){
    try {
      Fluttertoast.showToast(
        textColor: Colors.black,
        backgroundColor: Colors.white,
          msg: message,
          gravity: ToastGravity.CENTER
      );
    }
    catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static showSuccess(BuildContext context,{String? message}){
    // BuildContext? context=NavigationService.context;
    showDialog(
        context:context, builder: (context)
    =>  AlertDialog(
      insetPadding: const EdgeInsets.all(5),
      contentPadding: const EdgeInsets.all(5),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.done,color: Colors.green,size: 30,),
          const SizedBox(height: 20),
          const Text("Success!",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
          const SizedBox(height: 20),
          Text(message??''),
          const SizedBox(height: 30),
          Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Ok")))


        ],
      ),
    ));
  }
}