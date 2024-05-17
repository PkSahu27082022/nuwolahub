
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvolahub/AppManager/Component/App_theme_button.dart';
import 'package:nuvolahub/AppManager/Component/app_text_field.dart';
import 'package:nuvolahub/View/Account/login_view.dart';
import 'package:nuvolahub/ViewModel/AccountVM/register_view_model.dart';

import 'Widget/account_common_widget.dart';

class RegisterView extends StatefulWidget{
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
    get();
  }

  get(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RegisterViewModel.of(context).clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).textTheme;
    final registerVM=RegisterViewModel.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Lottie.asset("asset/json/register.json")),
              const SizedBox(height: 10),
              Text("Register Account",style:theme.titleLarge),
              const SizedBox(height: 30),
               AppTextField(
                controller: registerVM.userNameC,
                iconData: Icons.person_2_outlined,
                labelText: "User Name",
                hintText: "Enter User Name",
              ),
              const SizedBox(height: 20),
               AppTextField(
                controller: registerVM.mobileC,
                iconData: Icons.phone,
                labelText: "Mobile No.",
                hintText: "Enter Mobile No",
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: registerVM.emailC,
                iconData: Icons.email_outlined,
                labelText: "Email",
                hintText: "Enter Email",
              ),
              const SizedBox(height: 20),
               AppTextField(
                controller: registerVM.passC,
                iconData: Icons.visibility_outlined,
                labelText: "Password",
                hintText: "Enter Password",
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButtonTheme(data: AppButtonTheme.primary, child: TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        registerVM.register();
                      },
                      child: const Text("Register"),
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AccountCommonWidget(
                text: "Already have an account? ",
                buttonText: "Login here",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginView()));
                  },
              )

            ],

          ),
        ),
      ),
    );
  }
}