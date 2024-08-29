import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:snack_time/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> 

{
 String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  late Stream dbStreams2;
  onload() {
    dbStreams2 = FirebaseDatabase.instance.ref().child("Users")
          .child(userId).child("Orders").onValue;
  }

  @override
  void initState()  {
    userId =  FirebaseAuth.instance.currentUser!.uid.toString();
    onload();
    super.initState();
  }

  Widget verticalFoodItems() {
    return StreamBuilder(
      stream: dbStreams2,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          DatabaseEvent dbEvent = snapshot.data;
          Iterable<DataSnapshot> dbSnapshot = dbEvent.snapshot.children;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: dbSnapshot.length,
            itemBuilder: (BuildContext context, int index) {
              return  Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Material(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dbSnapshot.elementAt(index).child("count").value.toString(),
                            style: AppWidget.semiBoldTextFeildStyle(),
                          ),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                     ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              dbSnapshot.elementAt(index).child("image").value.toString(),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          )
                          ,
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 155,
                            child: Text(
                              dbSnapshot.elementAt(index).child("name").value.toString(),
                              style: AppWidget.profileFieldfont(),
                            ),
                          ),
                          Text(
                            "\$ "+dbSnapshot.elementAt(index).child("total price").value.toString(),
                            style: AppWidget.profileFieldfont(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Material(
              elevation: 2,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Order",
                  style: AppWidget.HeadlineTextFeildStyle(),
                ),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
               const Divider(),

             Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: verticalFoodItems(),
              ),
            ),
            //  const Divider(),
            //  const Spacer(),
            //  Padding(
            //    padding: const EdgeInsets.all(8.0),
            //    child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //      children: [
            //        Text("Total Price",style: AppWidget.boldTextFeildStyle(),),
            //        Text("\$ 100",style: AppWidget.semiBoldTextFeildStyle()),

            //      ],
            //    ),
            //  ),
            //  const SizedBox(height: 10,),
            //  Container(
            //   margin: const EdgeInsets.only(left: 20,right: 20),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
            //   color: Colors.black),
            //   child: Center(child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Text("CheckOut",style: AppWidget.WhiteTextFeildStyle(),),
            //   )),
            //  )   ,
            //  const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
