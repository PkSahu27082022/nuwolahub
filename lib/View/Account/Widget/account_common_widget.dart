
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountCommonWidget extends StatelessWidget{
  const AccountCommonWidget({super.key,this.recognizer,this.text,this.buttonText});

  final GestureRecognizer? recognizer;
  final String? text;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).textTheme;
   return Column(
     children: [
       const Row(
         children: [
           Expanded(
             child: Divider(
               color: Colors.grey,
               thickness: 2,
             ),
           ),
           Padding(
             padding: EdgeInsets.only(left: 5,right: 5),
             child: Text("Or"),
           ),
           Expanded(
             child: Divider(
               color: Colors.grey,
               thickness: 2,
             ),
           )
         ],
       ),
       const SizedBox(height: 10),
       Text.rich(
           TextSpan(
               style: theme.labelLarge,
               children:  [
                 TextSpan(
                     text:text
                 ),
                 TextSpan(
                     style: theme.labelLarge?.copyWith(color: Colors.blue.shade200),
                     text: buttonText,
                     recognizer: recognizer
                 )
               ]
           )
       ),
     ],
   );
  }
}