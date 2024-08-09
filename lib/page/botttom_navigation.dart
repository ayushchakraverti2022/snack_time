import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'order.dart';
import 'profile.dart';
import 'wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Order orderPage;
  late Profile profilePage;
  late Wallet walletPage;
  int currentTabIndex = 0;

  

  @override
  void initState() {
    homePage = Home();
    orderPage = Order();
    profilePage = Profile();
    walletPage = Wallet();
    pages = [homePage, orderPage, walletPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(Icons.home_outlined, color: Colors.white),

            Icon(            Icons.shopping_bag_outlined,
              color: Colors.white,
            ),

            Icon(
              Icons.wallet_rounded,
              color: Colors.white,
            ),
            
            Icon(Icons.person_outlined, color: Colors.white)
          ]),
          body: pages[currentTabIndex],
    );
  }
}
