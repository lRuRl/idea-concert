import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/pages/home/home.dart';
import 'package:iruri/pages/signup/signup.dart';
import 'package:iruri/pages/state/state_applylist.dart';
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';

Widget userInfoField(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          emailForm(),
          passwordForm(),
          nameForm(),
          phoneNumberForm(),
        ],
      ));
}

Widget emailForm() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(flex: 1, child: Text("아이디")),
        Expanded(
            flex: 5,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                fillColor: Colors.white,
                hintStyle: TextStyle(color: themeGrayText),
                hintText: '이메일 형식에 맞게 입력',
              ),
            ))
      ],
    ),
  );
}

Widget passwordForm() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(flex: 1, child: Text("비밀번호")),
        Expanded(
            flex: 5,
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                fillColor: Colors.white,
                hintStyle: TextStyle(color: themeGrayText),
                hintText: '영문 대, 소문자+숫자 8-15자',
              ),
            ))
      ],
    ),
  );
}

Widget nameForm() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(flex: 1, child: Text("이름")),
        Expanded(
            flex: 5,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                fillColor: Colors.white,
                hintStyle: TextStyle(color: themeGrayText),
                hintText: '실명 입력',
              ),
            ))
      ],
    ),
  );
}

Widget phoneNumberForm() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(flex: 1, child: Text("전화번호")),
        Expanded(
            flex: 5,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                ),
                fillColor: Colors.white,
                hintStyle: TextStyle(color: themeGrayText),
                hintText: '하이픈(-) 없이 입력',
              ),
            ))
      ],
    ),
  );
}

Widget registerButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Provider.of<CustomRouter>(context, listen: false)
            .setRegistrationStatus(true);
        Navigator.pop(context);
      },
      child: Text("가입하기"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
        primary: Colors.white,
        onPrimary: Color.fromRGBO(0x82, 0x82, 0x82, 1),
        // fixedSize: Size(90, 30),
      ));
}

class AgreeTerm extends StatefulWidget {
  final String content;
  AgreeTerm({this.content});
  @override
  _AgreeTermState createState() => _AgreeTermState();
}

class _AgreeTermState extends State<AgreeTerm> {
  bool _value = false;
  int index;
  String content;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border:
              Border.all(width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: MediaQuery.of(context).size.width * 1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: themeLightOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _value
                          ? Icon(
                              Icons.check,
                              size: 10.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 10.0,
                              color: themeLightOrange,
                            ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("이용약관 동의(필수)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
           Row(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: themeLightOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _value
                          ? Icon(
                              Icons.check,
                              size: 10.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 10.0,
                              color: themeLightOrange,
                            ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("개인정보수집 및 이용 동의(필수)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
           Row(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: themeLightOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _value
                          ? Icon(
                              Icons.check,
                              size: 10.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 10.0,
                              color: themeLightOrange,
                            ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("마케팅 수신동의(선택)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
        ]));
  }
}
