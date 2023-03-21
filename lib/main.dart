import 'package:flutter/material.dart';
import 'package:tbrtesttask/pages/homePage.dart';

import 'api_country/api_country.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'homePage',
    title: 'Test task',
    routes: {
      'homePage': (context) => homePage(),
    },
  ));
  ApiClient().getPost('https://restcountries.com/v3.1/all?fields=name,common,flags,svg,idd,root,suffixes`');

}
