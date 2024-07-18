import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvolahub/AppManager/Component/App_theme_button.dart';
import 'package:nuvolahub/AppManager/Component/app_text_field.dart';
import 'package:nuvolahub/View/Account/register_view.dart';
import 'package:nuvolahub/ViewModel/AccountVM/login_view_model.dart';

import 'Widget/account_common_widget.dart';
import 'Widget/password_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    get();
  }

  get(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LoginViewModel.of(context).clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).textTheme;
    final loginVM=LoginViewModel.of(context);
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: SingleChildScrollView(
          child: Form(
            child: Builder(
              builder: (ctx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Lottie.asset("asset/json/login.json"),
                    const SizedBox(height: 10),
                    Text("Account Login",style:theme.titleLarge),
                    const SizedBox(height: 30),
                    AppTextField(
                      validator: (val) {
                        if(val!.isEmpty){
                          return "Please enter mobile no.";
                        }else if(val.length!=10){
                          return "Please enter valid mobile no.";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      controller: loginVM.mobileC,
                      iconData: Icons.phone,
                      labelText: "Mobile No.",
                      hintText: "Enter Mobile No",
                    ),
                    const SizedBox(height: 20),
                    PasswordTextField(
                      // validator: (val){
                      //   RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      //   if(val!.isEmpty){
                      //     return "Please enter password.";
                      //   }else if(!regex.hasMatch(val)){
                      //     return "Please enter valid password.";
                      //   }else{
                      //     return null;
                      //   }
                      // },
                      labelText: "Password",
                      controller: loginVM.passC,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextButtonTheme(data: AppButtonTheme.primary, child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(Form.of(ctx).validate()){
                                loginVM.login();
                              }
                            },
                            child: const Text("Login"),
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AccountCommonWidget(
                      text: "Don't have an account? ",
                      buttonText: "Register here",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterView()));
                        },
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
