import 'package:flutter/material.dart';



class AppSnackBar {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static void show({required String message}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.black87,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.error_outlined, color: Colors.white, size: 40),
              const SizedBox(width: 10),
              Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
