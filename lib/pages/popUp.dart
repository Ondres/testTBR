import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tbrtesttask/api_country/api_country.dart';
import 'loadingPage.dart';

ScrollController _scrollController = new ScrollController();
TextEditingController _text_controller = new TextEditingController();
Color colorSearch = Colors.black87;
String _str = '';

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(142, 170, 251, 1),
            body: Container(
              child: Column(children: [
                bodyPart(),
              ]),
            )));
  }
}

class bodyPart extends StatefulWidget {
  const bodyPart({Key? key}) : super(key: key);

  @override
  State<bodyPart> createState() => _bodyPartState();
}

class _bodyPartState extends State<bodyPart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            height: 40,
            alignment: Alignment.centerLeft,
            child: Text(
              'Country code',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 245, 255, 0.4),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              width: 20,
              height: 20,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: EdgeInsets.all(0),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _str = '';
                      _text_controller.clear();
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black54,
                    size: 16,
                  ))),
        ],
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 24),
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 245, 255, 0.4),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        height: 48,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _str = value;
            });
          },
          onTap: () {
            setState(() {
              colorSearch = Colors.black54;
            });
          },
          autofocus: false,
          controller: _text_controller,
          style: TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Colors.black87,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: colorSearch),
            border: InputBorder.none,
            enabled: true,
          ),
        ),
      ),
      Container(
          padding: EdgeInsets.only(left: 15),
          height: MediaQuery.of(context).size.height * 0.75 - 5,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              controller: _scrollController,
              itemCount: country.length,
              itemBuilder: (_, index) {
                if (country[index]
                        .countryName
                        .toLowerCase()
                        .contains(_str.toLowerCase()) ||
                    country[index].phoneCode.contains(_str.toLowerCase()) ||
                    _str.toLowerCase().isEmpty)
                  return TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _text_controller.clear();
                          _str = '';
                          current_index = index;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              width: 40,
                              height: 30,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: SvgPicture.network(
                                    country[index].imgUrl,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 70,
                              height: 45,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                country[index].phoneCode,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.all(5),
                              height: 45,
                              width: 140,
                              child: Text(
                                country[index].countryName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                else
                  return Container();
              })),
    ]);
  }
}
