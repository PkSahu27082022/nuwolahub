import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Service/navigation_service.dart';
import 'package:nuvolahub/ViewModel/AccountVM/login_view_model.dart';
import 'package:nuvolahub/ViewModel/AccountVM/register_view_model.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/ViewModel/paper_view_model.dart';
import 'package:nuvolahub/ViewModel/quiz_view_model.dart';
import 'package:provider/provider.dart';

import 'AppManager/Helper/snack_bar.dart';
import 'View/Account/login_view.dart';
import 'View/category_view.dart';
import 'View/quiz_view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
    ChangeNotifierProvider<RegisterViewModel>(
        create: (_) => RegisterViewModel()),
    ChangeNotifierProvider<CategoryViewModel>(
        create: (_) => CategoryViewModel()),
    ChangeNotifierProvider<PaperViewModel>(create: (_) => PaperViewModel()),
    ChangeNotifierProvider<QuizViewModel>(create: (_) => QuizViewModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)
          )
        ),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))))),
      scaffoldMessengerKey: AppSnackBar.scaffoldKey,
      navigatorKey: NavigationService.navigatorKey,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child:
      //CategoryView()
      //QuizView()
      LoginView(),
    );
  }
}
