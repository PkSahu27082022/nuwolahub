import 'package:flutter/material.dart';

class AppButtonTheme {

  static TextButtonThemeData primary = TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        side: BorderSide(color: Colors.pink.shade200),
        elevation: 5,
        shadowColor: Colors.black),
  );





}
