import 'package:flutter/material.dart';
import 'package:tbrtesttask/pages/homePage.dart';
import 'package:tbrtesttask/pages/loadingPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'loadingPage',
    title: 'Test task',
    routes: {
      'homePage': (context) => homePage(),
      'loadingPage': (context) => loadingPage(),
    },
  ));
}
