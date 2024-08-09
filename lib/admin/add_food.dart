import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_time/controllers/add_food.dart';
import 'package:snack_time/models/addfood.dart';
import 'package:snack_time/widget/widget_support.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> fooditems = ['Ice-cream', 'Burger', 'Salad', 'Pizza'];
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();

  AddFoodController addFoodController = (AddFoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF373866),
            )),
        centerTitle: true,
        title: Text(
          "Add Item",
          style: AppWidget.HeadlineTextFeildStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    addFoodController.pickImage();
                  },
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() =>addFoodController.addFoodModel.value.itemImage==null? const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ):ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(addFoodController.addFoodModel.value.itemImage!,fit: BoxFit.cover,))
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Name",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Name",
                      hintStyle: AppWidget.LightTextFeildStyle()),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Price",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price",
                      hintStyle: AppWidget.LightTextFeildStyle()),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Detail",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: detailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail",
                      hintStyle: AppWidget.LightTextFeildStyle()),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Select Category",
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  items: fooditems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style:
                                const TextStyle(fontSize: 18.0, color: Colors.black),
                          )))
                      .toList(),
                  onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                  dropdownColor: Colors.white,
                  hint: const Text("Select Category"),
                  iconSize: 36,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  value: value,
                )),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    addFoodController.addFoodModel.value.itemCategory = value;
                    addFoodController.addFoodModel.value.itemDetail = detailcontroller.value.text;
                    addFoodController.addFoodModel.value.itemName = namecontroller.value.text;
                    addFoodController.addFoodModel.value.itemPrice =  pricecontroller.value.text;

                    var message = await addFoodController.uploadToDatabase(addFoodController.addFoodModel.value);                 
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${message}")));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
