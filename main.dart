import 'package:flutter/material.dart';
import 'package:login1/Controller/home.dart';
import 'package:login1/Controller/productDetailPage.dart';
import 'package:login1/Screens/HomePage.dart';
import 'package:login1/Screens/bottomnav.dart';
import 'package:login1/Screens/loginPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: bottomnav(),
    );
  }
}
