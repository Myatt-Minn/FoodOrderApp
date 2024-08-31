import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_fooddeliveryapp/pages/Order.dart';
import 'package:flutter_fooddeliveryapp/pages/Profile.dart';
import 'package:flutter_fooddeliveryapp/pages/Wallet.dart';
import 'package:flutter_fooddeliveryapp/pages/home.dart';

class Bottomnavi extends StatefulWidget {
  const Bottomnavi({super.key});

  @override
  State<Bottomnavi> createState() => _BottomnaviState();
}

class _BottomnaviState extends State<Bottomnavi> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const Order(),
    const Wallet(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          animationDuration: const Duration(milliseconds: 500),
          color: Colors.black,
          backgroundColor: Colors.white,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              size: 28,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              size: 28,
              color: Colors.white,
            ),
            Icon(
              Icons.wallet_outlined,
              size: 28,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              size: 28,
              color: Colors.white,
            ),
          ]),
    );
  }
}
