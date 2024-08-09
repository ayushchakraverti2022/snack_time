import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_time/page/details.dart';
import 'package:snack_time/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool salad = true, pizza = false, ice_cream = false, burger = false;
  late Stream dbStreams;
  late Stream dbStreams2;
  String foodItem = "Salad";
  onload() {
    dbStreams = FirebaseDatabase.instance
        .ref()
        .child("FoodItems")
        .child(foodItem)
        .onValue;
    dbStreams2 = FirebaseDatabase.instance
        .ref()
        .child("FoodItems")
        .child(foodItem)
        .onValue;
  }

  @override
  void initState() {
    // BlocProvider.of<DatabaseCubit>(context).load();
    onload();

    super.initState();
  }

  Widget verticalFoodItems() {
    return StreamBuilder(
      stream: dbStreams2,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        DatabaseEvent dbEvent = snapshot.data;
        Iterable<DataSnapshot> dbSnapshot = dbEvent.snapshot.children;

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: dbSnapshot.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(Details(
                    image: dbSnapshot
                        .elementAt(index)
                        .child("image")
                        .value
                        .toString(),
                    name: dbSnapshot
                        .elementAt(index)
                        .child("name")
                        .value
                        .toString(),
                    detail: dbSnapshot
                        .elementAt(index)
                        .child("detail")
                        .value
                        .toString(),
                    price: dbSnapshot
                        .elementAt(index)
                        .child("price")
                        .value.toString()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 5.0, right: 5),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                dbSnapshot
                                    .elementAt(index)
                                    .child("image")
                                    .value
                                    .toString(),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dbSnapshot
                                    .elementAt(index)
                                    .child("name")
                                    .value
                                    .toString(),
                                style: AppWidget.semiBoldTextFeildStyle(),
                              ),
                              Text(
                                dbSnapshot
                                    .elementAt(index)
                                    .child("detail")
                                    .value
                                    .toString(),
                                style: AppWidget.LightTextFeildStyle(),
                              ),
                              Text(
                                  "\$" +
                                      dbSnapshot
                                          .elementAt(index)
                                          .child("price")
                                          .value
                                          .toString(),
                                  style: AppWidget.semiBoldTextFeildStyle())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget horizontalFoodItems() {
    return StreamBuilder(
      stream: dbStreams,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        DatabaseEvent dbEvent = snapshot.data;
        Iterable<DataSnapshot> dbSnapshot = dbEvent.snapshot.children;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dbSnapshot.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(Details(
                    image: dbSnapshot
                        .elementAt(index)
                        .child("image")
                        .value
                        .toString(),
                    name: dbSnapshot
                        .elementAt(index)
                        .child("name")
                        .value
                        .toString(),
                    detail: dbSnapshot
                        .elementAt(index)
                        .child("detail")
                        .value
                        .toString(),
                    price: dbSnapshot
                        .elementAt(index)
                        .child("price")
                        .value
                        .toString() ));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  dbSnapshot
                                      .elementAt(index)
                                      .child("image")
                                      .value
                                      .toString(),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dbSnapshot
                                        .elementAt(index)
                                        .child("name")
                                        .value
                                        .toString(),
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  ),
                                  Text(
                                    dbSnapshot
                                        .elementAt(index)
                                        .child("detail")
                                        .value
                                        .toString(),
                                    style: AppWidget.LightTextFeildStyle(),
                                  ),
                                  Text(
                                      "\$" +
                                          dbSnapshot
                                              .elementAt(index)
                                              .child("price")
                                              .value
                                              .toString(),
                                      style: AppWidget.semiBoldTextFeildStyle())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hi, Ayush", style: AppWidget.LightTextFeildStyle()),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Delicious Food",
            style: AppWidget.LightTextFeildStyle(),
          ),
          Text(
            "Discover and get Great Food",
            style: AppWidget.boldTextFeildStyle(),
          ),
          const SizedBox(height: 5),
          showItems(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: horizontalFoodItems(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: verticalFoodItems(),
            ),
          ),
        ]),
      ),
    );
  }

  Widget showItems() {
    // Categories of Salad, pizza, burger, ice cream
    // salad
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            salad = true;
            pizza = false;
            foodItem = "Salad";
            burger = false;
            ice_cream = false;
            setState(() {
              onload();
            });
          },
          child: Material(
            elevation: salad ? 10 : 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Image.asset('images/salad.png',
                    height: 40, width: 40, fit: BoxFit.cover)),
          ),
        ),
        //buger
        GestureDetector(
          onTap: () {
            salad = false;
            pizza = false;
            burger = true;
            ice_cream = false;
            foodItem = "Burger";
            setState(() {
              onload();
            });
          },
          child: Material(
            elevation: burger ? 10 : 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Image.asset('images/burger.png',
                    height: 40, width: 40, fit: BoxFit.cover)),
          ),
        ),
        //ice cream
        GestureDetector(
          onTap: () {
            salad = false;
            pizza = false;
            burger = false;
            foodItem = "Ice-cream";
            ice_cream = true;
            setState(() {
              onload();
            });
          },
          child: Material(
            elevation: ice_cream ? 10 : 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Image.asset('images/ice-cream.png',
                    height: 40, width: 40, fit: BoxFit.cover)),
          ),
        ),
        // pizza
        GestureDetector(
          onTap: () {
            salad = false;
            foodItem = "Pizza";
            pizza = true;
            burger = false;
            ice_cream = false;
            setState(() {
              onload();
            });
          },
          child: Material(
            elevation: pizza ? 10 : 1,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Image.asset('images/pizza.png',
                    height: 40, width: 40, fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}
