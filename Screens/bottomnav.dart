import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login1/Screens/HomePage.dart';
import 'package:login1/Screens/productPage.dart';
import 'package:login1/Screens/product_detail_page.dart';
import 'package:login1/Screens/profilePage.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int currentTabIndex=0;
  late List<Widget> pages;

  late Widget currentPage;
  late home1 Home;
  late profilePage Profile;
  late ProductListPage productListPage;
  
  @override
  void initState() {
    Home =home1();
    Profile = profilePage();
    productListPage = ProductListPage();
    pages = [Home, productListPage, Profile];
    currentPage = home1();
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
        onTap: (int index){
          setState(() {
            currentTabIndex= index;
          });
        },
        items: [
        Icon(Icons.home_outlined,color: Colors.white,size: 30,),
          Icon(Icons.shopping_bag,color: Colors.white,size: 30,),
          // Icon(Icons.person,color: Colors.white,size: 30,),
          
          ],
          ),
          body: pages[currentTabIndex],
    );
  }
}