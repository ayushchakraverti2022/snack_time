import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_time/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  TextEditingController? amountcontroller = TextEditingController();
  String amount = "0";

  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.cancel)),
                        const SizedBox(
                          width: 60.0,
                        ),
                        const Center(
                          child: Text(
                            "Add Money",
                            style: TextStyle(
                              color: Color(0xFF008080),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Amount"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 2.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: amountcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter Amount'),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // makePayment(amountcontroller.text);
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF008080),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseDatabase.instance
                                  .ref()
                                  .child("Users")
                                  .child(userId)
                                  .child("balance")                                
                                  .set(int.parse(amount )+ int.parse(amountcontroller!.value.text.toString())
                              );
                              Get.snackbar("Wallet","Money added",
                                  snackPosition: SnackPosition.BOTTOM);
                              setState(() {
                                 FirebaseDatabase.instance
        .ref()
        .child("Users")
        .child(userId)
        .child("balance")
        .get()
        .then((onValue) {
      amount = onValue.value.toString();
      setState(() {});
    });
                              });
                            },
                            child: const Center(
                                child: Text(
                              "Pay",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));

  @override
  void initState() {
    FirebaseDatabase.instance
        .ref()
        .child("Users")
        .child(userId)
        .child("balance")
        .get()
        .then((onValue) {
      amount = onValue.value.toString();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                    child: Text(
                  "Wallet",
                  style: AppWidget.HeadlineTextFeildStyle(),
                )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Row(
                children: [
                  Image.asset(
                    'images/wallet.png',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your wallet",
                        style: AppWidget.LightTextFeildStyle(),
                      ),
                      Text("${amount}", style: AppWidget.boldTextFeildStyle())
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Add money",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE9E2E2),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "\$ 200",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE9E2E2),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "\$ 500",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE9E2E2),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "\$ 1000",
                        style: AppWidget.semiBoldTextFeildStyle(),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE9E2E2),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "\$ 2000",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                openEdit();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFF008080),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Add money",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
