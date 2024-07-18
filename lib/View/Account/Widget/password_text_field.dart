import 'package:flutter/material.dart';


class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, this.controller, this.labelText});
  final TextEditingController? controller;
  final String? labelText;
 // final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool _visibilityOn = true;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText ?? "",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: (val){
            RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if(val!.isEmpty){
              return "Please enter password.";
            }else if(!regex.hasMatch(val)){
              return "Please enter valid password.";
            }else{
              return null;
            }
          },
          obscureText: _visibilityOn,
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: "Enter Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              fillColor: Colors.green.shade50,
              filled: true,
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _visibilityOn=!_visibilityOn;
                    });
                  },
                  child: Icon(
                      _visibilityOn
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey))),
        ),
      ],
    );
  }
}
