import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/pages/signup/signup.dart';
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';

Widget appImage(BuildContext context) {
  return Center(
    child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset('assets/default.png')),
  );
}

Widget appName(BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text('IRURI',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
}

Widget getUserInfo(BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(children: <Widget>[
        Padding(
          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              disabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              fillColor: Colors.white,
              labelStyle: TextStyle(color: themeGrayText),
              labelText: 'Email address or Id',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              disabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              fillColor: Colors.white,
              labelStyle: TextStyle(color: themeGrayText),
              labelText: 'Password',
            ),
          ),
        ),
      ]));
}

Widget loginButton(BuildContext context) {
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();

  return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ElevatedButton(
          onPressed: () {
            Provider.of<CustomRouter>(context, listen: false)
                .setRegistrationStatus(true);
            routerReader.navigateTo(routerWatcher.currentPage, '/');
          },
          child: Text("로그인",
              style: buttonWhiteTextStyle),
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            padding: paddingH10V10,
            //fixedSize: Size(90, 30),
            primary: primary,
            onPrimary: Colors.white,
          )));
}

Widget findInfo(BuildContext context) {

  return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: themeGrayText
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('회원가입'),
            ),
            Text('|', style: TextStyle(color: themeGrayText)),
            TextButton(
              style: TextButton.styleFrom(
                primary: themeGrayText
              ),
              onPressed: null,
              child: Text('아이디 찾기'),
            ),
            Text('|', style: TextStyle(color: themeGrayText)),
            TextButton(
              style: TextButton.styleFrom(
                primary: themeGrayText
              ),
              onPressed: null,
              child: Text('비밀번호 찾기'),
            )
          ]));
}

Widget selectLogin(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            snsIcon(context, "구글"),
            snsIcon(context, "네이버"),
            snsIcon(context, "카카오톡"),
            snsIcon(context, "애플"),
          ]));
}

Widget snsIcon(BuildContext context, String type) {
  return Column(
    children: [
      InkWell(
          onTap: () {},
          child: Container(
              child: ClipRRect(
            child: Image.asset(
              'assets/${type}.png',
              width: MediaQuery.of(context).size.width * 0.06,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ))),
      Text(
        "${type} 계정으로\n로그인",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      )
    ],
  );
}
