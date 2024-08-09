import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:snack_time/cubits/sign/sign_up_cubit.dart';
import 'package:snack_time/page/botttom_navigation.dart';
import 'package:snack_time/page/login.dart';
import 'package:snack_time/widget/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool connected = true;
  String name = "", password = "", email = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  StreamSubscription? internetChecker;

  @override
  void initState() {
    internetChecker =
        InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.disconnected) {
        connected = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please connect to the internet")));
      } else {
        connected = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    internetChecker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignedUpState) {
          Get.offAll(BottomNav());
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
                    Color.fromARGB(255, 235, 174, 148),
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
                      height: MediaQuery.of(context).size.height / 1.8,
                      width: MediaQuery.of(context).size.width - 20,
                      // Sign Up Starts form here
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Sign Up",
                              style: AppWidget.HeadlineTextFeildStyle(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter name.";
                                  }
                                  return null;
                                },
                                controller: nameController,
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: AppWidget.LightTextFeildStyle(),
                                    prefixIcon:
                                        const Icon(Icons.person_outlined)),
                                keyboardType: TextInputType.name,
                              ),
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
                                keyboardType: TextInputType.emailAddress,
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
                                      const Icon(Icons.password_outlined),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                obscuringCharacter: '*',
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  name = nameController.value.text.toString();
                                  password =
                                      passwordController.value.text.toString();
                                  email = emailController.value.text.toString();

                                  BlocProvider.of<SignUpCubit>(context)
                                      .registration(name, email, password);
                                }
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 100,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "SignUp",
                                    style: AppWidget.WhiteTextFeildStyle(),
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
                        // Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Login()));
                      },
                      child: Text(
                        "Already have account? Login here",
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
