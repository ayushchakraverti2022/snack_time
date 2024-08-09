import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack_time/models/addfood.dart';

class AddFoodController extends GetxController {
  var addFoodModel = AddFoodModel().obs;
  ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      addFoodModel.update((addFoodModel) {
        addFoodModel?.itemImage = File(pickedFile.path);
      });
    }
  }

   Future<String> uploadToDatabase(AddFoodModel foodmodel) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      
      String fileName = '${foodmodel.itemCategory}/${DateTime.now().millisecondsSinceEpoch}.png';

      // Upload the file
      await _storage.ref(fileName).putFile(foodmodel.itemImage!);

      // Get the download URL

      String downloadURL = await _storage.ref(fileName).getDownloadURL();
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref
          .child("FoodItems")
          .child(foodmodel.itemCategory.toString())
          .child(foodmodel.itemName.toString())
          .child("image")
          .set(downloadURL);

      ref
          .child("FoodItems")
          .child(foodmodel.itemCategory.toString())
          .child(foodmodel.itemName.toString())
          .child("name")
          .set(foodmodel.itemName.toString()); 
      
      ref
          .child("FoodItems")
          .child(foodmodel.itemCategory.toString())
          .child(foodmodel.itemName.toString())
          .child("detail")
          .set(foodmodel.itemDetail);
      ref
          .child("FoodItems")
          .child(foodmodel.itemCategory.toString())
          .child(foodmodel.itemName.toString())
          .child("price")
          .set(foodmodel.itemPrice);
      return "Uploaded Successfully";
     
    } catch (e) {
      return e.toString();
    }
  }
}
