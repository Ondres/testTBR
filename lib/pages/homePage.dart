import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:tbrtesttask/pages/popUp.dart';
import '../api_country/api_country.dart';
import 'loadingPage.dart';

late AnimationController _animationController;
late Animation<double> _animation;
Radius _radius = Radius.circular(0);
TextEditingController _phone_controller = new TextEditingController();
int lenght = 0;

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation =
        Tween<double>(begin: 1.0, end: 0.95).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.scale(
            scale: _animation.value,
            child:
                Scaffold(backgroundColor: Colors.transparent, body: Home())));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(142, 170, 251, 1),
        borderRadius: BorderRadius.only(topLeft: _radius, topRight: _radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 60, 11, 160),
            height: 40,
            alignment: Alignment.centerLeft,
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 140),
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  width: 85,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 255, 0.4),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {
                        setState(() {
                          colorSearch = Colors.black87;
                          _radius = Radius.circular(16);
                        });
                        _animationController
                            .forward(); // запуск анимации уменьшения фонового виджета
                        showCupertinoModalBottomSheet(
                          expand: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => PopUp(),
                        ).then((value) => {
                              _animationController.reverse(),
                              setState(() {
                                _radius = Radius.circular(0);
                              })
                            }); // запуск анимации увеличения фонового виджета после закрытия модального окна
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: 30,
                              height: 25,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: SvgPicture.network(
                                    country.isNotEmpty
                                        ? country[current_index].imgUrl
                                        : 'https://flagcdn.com/ao.svg',
                                    fit: BoxFit.contain,
                                  ))),
                          Text(
                            country.isNotEmpty
                                ? country[current_index].phoneCode
                                : '+244',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 255, 0.4),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  height: 48,
                  width: 256,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        lenght = value.length;
                      });
                    },
                    inputFormatters: [
                      InputFormatter(),
                      LengthLimitingTextInputFormatter(14),
                    ],
                    keyboardType: TextInputType.phone,
                    keyboardAppearance: Brightness.dark,
                    smartDashesType: SmartDashesType.disabled,
                    autofocus: true,
                    controller: _phone_controller,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Your phone number",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                      enabled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(307, 0, 20, 0),
              decoration: BoxDecoration(
                color: _phone_controller.text.length < 14
                    ? Color.fromRGBO(244, 245, 255, 0.4)
                    : Color.fromRGBO(244, 245, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              width: 48,
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.all(0),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    _phone_controller.text.length < 14
                        ? print("Positiv vibes :)")
                        : print("None positiv vibes :(");
                  },
                  child: Container(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.arrow_forward,
                        color: _phone_controller.text.length < 14
                            ? Colors.black54
                            : Colors.black,
                      )))),
        ],
      ),
    );
  }
}

class InputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final str = newValue.text;
    final charStr = str.split('');
    var newStr = <String>[];
    for (int i = 0; i < str.length; i++) {
      if (str.length == 6 &&
          i == 5 &&
          oldValue.text.length < newValue.text.length) newStr.add(' ');

      if (i == 0 &&
          str.length == 1 &&
          oldValue.text.length < newValue.text.length) {
        newStr.add('(');
      }
      newStr.add(charStr[i]);

      if (i == 3 &&
          str.length == 5 &&
          oldValue.text.length < newValue.text.length) {
        newStr.add(') ');
      }

      if (i == 8 &&
          str.length == 10 &&
          oldValue.text.length < newValue.text.length) {
        newStr.add('-');
      }
    }
    final resultStr = newStr.join('');
    return TextEditingValue(
      text: resultStr,
      selection: TextSelection.collapsed(offset: resultStr.length),
    );
  }
}
