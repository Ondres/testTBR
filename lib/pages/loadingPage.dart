import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tbrtesttask/pages/popUp.dart';
import '../api_country/api_country.dart';
import '../classes/Country.dart';
import 'homePage.dart';
import 'package:geocoding/geocoding.dart';

bool _start = false;
late int current_index;

Future<int> getCountry() async {
  try {
    final position = await Geolocator.getCurrentPosition();
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final _country = placemarks.first.country;
    if (_country != null) {
      for (int i = 0; i < names.length; i++) {
        if (_country == names[i]) {
          return i;
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return 0;
}

Future<int> AddAndCount(String text, BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });

  try {
    await ApiClient().getPost(text);
  } catch (e) {
    if (ApiClient().getPost(text) != 200)
      print(" Response status code is " + ApiClient().getPost(text).toString());
  }
  return 0;
}

class loadingPage extends StatefulWidget {
  const loadingPage({Key? key}) : super(key: key);

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (!_start) {
        setState(() {
          print(_start);
          _start = true;
        });
        await AddAndCount(
            'https://restcountries.com/v3.1/all?fields=name,common,flags,svg,idd,root,suffixes`',
            context);
        var a = await getCountry();
        print("a = " + a.toString());
        setState(() {
          current_index = a;
        });
        Navigator.of(context).pushReplacementNamed('homePage');
      }
    });
    return Container(
      color: Color.fromRGBO(142, 170, 251, 1),
    );
  }
}
