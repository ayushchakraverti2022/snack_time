import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_time/service/database.dart';
import 'package:snack_time/service/shared_pref.dart';
import 'package:snack_time/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Material(
              elevation: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Food Cart",style: AppWidget.HeadlineTextFeildStyle(),),
                )),
            ),
            SizedBox(height: 10,),

             Padding(
               padding:  EdgeInsets.only(top: 8.0,left: 10,right: 10),
               child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),                        
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("2",style: AppWidget.semiBoldTextFeildStyle(),),
                        )),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
                        child: Image.asset("images/salad4.png",width: 90,height: 90,)),
                         SizedBox(width: 10,),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Salad",style: AppWidget.profileFieldfont(),),
                          Text("\$ 40",style: AppWidget.profileFieldfont(),)
                        ],
                      )
                    ],
                  ),              
                ),
            ),
             ) ,
             Divider(),
             Spacer(),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Total Price",style: AppWidget.boldTextFeildStyle(),),
                   Text("\$ 100",style: AppWidget.semiBoldTextFeildStyle()),

                 ],
               ),
             ), 
             SizedBox(height: 10,),
             Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              color: Colors.black),
              child: Center(child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("CheckOut",style: AppWidget.WhiteTextFeildStyle(),),
              )),
             )   ,
             SizedBox(height: 20,)      
          ],
        ),
      ),
    );
  }
}
