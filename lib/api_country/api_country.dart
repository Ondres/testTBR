import 'dart:convert';
import 'package:http/http.dart';
import 'package:tbrtesttask/classes/Country.dart';

List<Country> country = [];
List<String> names = [];

class ApiClient {
  Future<int> getPost(String text) async {
    final response = await get(Uri.parse(text));
    print("Start of response");
    if (response.statusCode == 200) {
      int i = 0;
      List<dynamic> ns = jsonDecode(response.body);
      for (i; i < ns.length; i++) {
        List<dynamic> l = ns[i]['idd']['suffixes'];
        if (ns[i]['name']['common'] != null &&
            ns[i]['idd']['root'] != null &&
            ns[i]['flags']['svg'] != null) {
          names.add(ns[i]['name']['common']);
          country.add(Country(
            countryName: ns[i]['name']['common'],
            phoneCode: l.length > 0
                ? ns[i]['idd']['root'] + l[0].toString()
                : ns[i]['idd']['root'],
            imgUrl: ns[i]['flags']['svg'],
          ));
        }
      }
      country.sort((a, b) => a.countryName.compareTo(b.countryName));
      names.sort((a, b) => a.compareTo(b));
      print("End of response");
      return (200);
    } else {
      return response.statusCode;
    }
  }
}
