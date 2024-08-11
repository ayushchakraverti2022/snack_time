import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_time/controllers/add_food_to_cart.dart';
import 'package:snack_time/models/addcartfood.dart';
import 'package:snack_time/widget/widget_support.dart';

class Details extends StatefulWidget {
  String image;
  String name;
  String price;
  String detail;

  Details({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
   String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  int count = 1;
  late int amount;
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  void initState() {
    amount = int.parse(widget.price);
    super.initState();
  }

  AddFoodToCartController addFoodToCartController =
      Get.put(AddFoodToCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.black)),
            SizedBox(
              height: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.image,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.name,
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (count == 1) {
                        } else {
                          --count;
                          amount = amount - (int.parse(widget.price));
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: const Icon(
                          Icons.remove,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "$count",
                        style: AppWidget.semiBoldTextFeildStyle(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          ++count;
                          amount = amount + (int.parse(widget.price));
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.detail,
                style: AppWidget.LightTextFeildStyle(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Delivery Time ",
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                const Spacer(),
                const Icon(
                  Icons.alarm,
                  size: 25,
                ),
                Text(
                  "35 Minutes ",
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Total Price",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                    Text(
                      "\$" + amount.toString(),
                      style: AppWidget.HeadlineTextFeildStyle(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    AddFoodToCartModel addFoodToCartModel =
                        AddFoodToCartModel();
                    addFoodToCartModel.itemName = widget.name;
                    addFoodToCartModel.itemCount = count.toString();
                    addFoodToCartModel.itemDetail = widget.detail;
                    addFoodToCartModel.itemTotalPrice = amount.toString();
                    addFoodToCartModel.itemPrice = widget.price;
                    addFoodToCartModel.itemImage = widget.image;

                    String message = await addFoodToCartController
                        .uploadToDatabase(addFoodToCartModel, uid);
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${message}")));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.only(right: 5),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Add to cart ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins'),
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
