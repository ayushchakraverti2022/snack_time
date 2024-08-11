import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:snack_time/models/addcartfood.dart';

class AddFoodToCartController extends GetxController {
  var addFoodModel = AddFoodToCartModel().obs;

  Future<String> uploadToDatabase(
      AddFoodToCartModel foodmodel, String userId) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("total price")
          .set(foodmodel.itemTotalPrice.toString());
      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("image")
          .set(foodmodel.itemImage.toString());
      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("count")
          .set(foodmodel.itemCount.toString());

      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("name")
          .set(foodmodel.itemName.toString());

      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("detail")
          .set(foodmodel.itemDetail);
      ref
          .child("Users")
          .child(userId)
          .child("CartItems")
          .child(foodmodel.itemName.toString())
          .child("price")
          .set(foodmodel.itemPrice);
      return "Added Successfully";
    } catch (e) {
      return e.toString();
    }
  }
}
