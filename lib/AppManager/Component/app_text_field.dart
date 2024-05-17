import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.iconData,
    this.labelText,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hintText;
  final IconData? iconData;
  final String? labelText;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? "",
          style: theme.labelLarge,
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              fillColor: Colors.green.shade50,
              filled: true,
              suffixIcon: Icon(iconData, color: Colors.grey)),
        ),
      ],
    );
  }
}
