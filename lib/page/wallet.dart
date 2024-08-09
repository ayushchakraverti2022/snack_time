

import 'package:flutter/material.dart';
import 'package:snack_time/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(child: Text("Wallet", style: AppWidget.HeadlineTextFeildStyle(),)),
              ),
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
            child: Row(
              children: [
                Image.asset('images/wallet.png',height: 60, width: 60,fit: BoxFit.cover,),
                SizedBox(width: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your wallet",style: AppWidget.LightTextFeildStyle(),),
                    Text("\$ 100",style: AppWidget.boldTextFeildStyle(),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Add money",style: AppWidget.semiBoldTextFeildStyle(),),
          ),
           SizedBox(height: 10,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE9E2E2),),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("\$ 200",style: AppWidget.semiBoldTextFeildStyle(),),
              )
            ,
            
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE9E2E2),),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("\$ 500",style: AppWidget.semiBoldTextFeildStyle(),),
              )
            ,
           
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE9E2E2),),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("\$ 1000",style: AppWidget.semiBoldTextFeildStyle(),),
              )
            ,
           
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE9E2E2),),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("\$ 2000",style: AppWidget.semiBoldTextFeildStyle(),),
              )
            ,
            ],
           ),
           SizedBox(height: 50,),
           Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 12.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF008080),
              borderRadius: BorderRadius.circular(10)
          
            ),
            child: Center(child: Text("Add money",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.bold),)),
           )

          ],),
      ) ,
    );
  }
}
