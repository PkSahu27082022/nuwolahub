
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvolahub/AppManager/Component/App_theme_button.dart';
import 'package:nuvolahub/AppManager/Component/app_text_field.dart';
import 'package:nuvolahub/View/Account/login_view.dart';
import 'package:nuvolahub/ViewModel/AccountVM/register_view_model.dart';

import 'Widget/account_common_widget.dart';
import 'Widget/password_text_field.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Builder(
              builder: (ctx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.center,
                        child: Lottie.asset("asset/json/register.json")),
                    const SizedBox(height: 10),
                    Text("Register Account",style:theme.titleLarge),
                    const SizedBox(height: 30),
                     AppTextField(
                       validator: (val){
                         if(val!.isEmpty){
                           return "Please enter user name";
                         }else if(val.length<=3 && val.length>=20){
                           return "Invalid user name";
                         }else if(val.length>=20){
                           return "Invalid user name";
                         }
                         else{
                           return null;
                         }
                       },
                      controller: registerVM.userNameC,
                      iconData: Icons.person_2_outlined,
                      labelText: "User Name",
                      hintText: "Enter User Name",
                    ),
                    const SizedBox(height: 20),
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
                      controller: registerVM.mobileC,
                      iconData: Icons.phone,
                      labelText: "Mobile No.",
                      hintText: "Enter Mobile No",
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      validator: (val){
                        RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if(val!.isEmpty){
                          return "Please enter email.";
                        }else if(!regex.hasMatch(val)){
                          return "Please enter valid email";
                        }else{
                          return null;
                        }
                      },
                      controller: registerVM.emailC,
                      iconData: Icons.email_outlined,
                      labelText: "Email",
                      hintText: "Enter Email",
                    ),
                    const SizedBox(height: 20),
                    PasswordTextField(
                      controller: registerVM.passC,
                      labelText: "Password"
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextButtonTheme(data: AppButtonTheme.primary, child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(Form.of(ctx).validate()){
                                registerVM.register();
                              }
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
                    ),
                    const SizedBox(height: 20)

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