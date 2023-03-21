import 'dart:convert';
import 'package:http/http.dart';
import 'package:tbrtesttask/classes/Country.dart';

List<Country> country = [];

class ApiClient {
  Future<int> getPost(String text) async {
    final response = await get(Uri.parse(text));

    if (response.statusCode == 200) {
      int i = 0;
      List<dynamic> ns = jsonDecode(response.body);
      for (i; i < ns.length; i++) {
        List<dynamic> l = jsonDecode(response.body)[i]['idd']['suffixes'];
        if (jsonDecode(response.body)[i]['name']['common'] != null &&
            jsonDecode(response.body)[i]['idd']['root'] != null &&
            jsonDecode(response.body)[i]['flags']['svg'] != null)
          country.add(Country(
            countryName: jsonDecode(response.body)[i]['name']['common'],
            phoneCode: l.length > 0
                ? jsonDecode(response.body)[i]['idd']['root'] + l[0].toString()
                : jsonDecode(response.body)[i]['idd']['root'],
            imgUrl: jsonDecode(response.body)[i]['flags']['svg'],
          ));
      }
      country.sort((a, b) => a.countryName.compareTo(b.countryName));
      return (200);
    } else {
      return response.statusCode;
    }
  }
}
