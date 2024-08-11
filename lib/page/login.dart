import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:snack_time/cubits/login/login_cubit.dart';
import 'package:snack_time/page/forgotpassword.dart';
import 'package:snack_time/widget/widget_support.dart';

import 'botttom_navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String password = "", email = "";
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoggedInState) {
          Get.offAll(BottomNav());
        } else if (state is LoginFailState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${state.error}")));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 224, 144, 109),
                    Color.fromARGB(255, 255, 98, 0)
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'images/logo.png',
                    scale: 1,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Login",
                              style: AppWidget.HeadlineTextFeildStyle(),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter E-mail.";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: AppWidget.LightTextFeildStyle(),
                                    prefixIcon: const Icon(Icons.mail_outline)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter password.";
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: AppWidget.LightTextFeildStyle(),
                                    prefixIcon:
                                        const Icon(Icons.password_outlined)),
                                obscureText: true,
                                obscuringCharacter: '*',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(ForgotPassword());
                                    },
                                    child: Text(
                                      "Forgot password ?",
                                      style: AppWidget.semiBoldTextFeildStyle(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNav()));
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          password = passwordController
                                              .value.text
                                              .toString();
                                          email = emailController.value.text
                                              .toString();
                                          BlocProvider.of<LoginCubit>(context)
                                              .userLogin(email, password);
                                        },
                                      );
                                    }
                                    ;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 100,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Login",
                                        style: AppWidget.WhiteTextFeildStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=> SignUp() ));
                      },
                      child: Text(
                        "Don't have account? SignUp here",
                        style: AppWidget.semiBoldTextFeildStyle(),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
