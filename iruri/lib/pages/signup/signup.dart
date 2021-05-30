import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/pages/signup/signup_util.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageeState createState() => _SignUpPageeState();
}

class _SignUpPageeState extends State<SignUpPage> {
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(page[currentPageIndex]['name'], style: appBarTitleTextStyle),
          centerTitle: true,
          title: Text(
            '회원가입',
            style: appBarTitleTextStyle,
          ),
          backgroundColor: Colors.white,
          shadowColor: themeLightGrayOpacity20,
          elevation: 1.0,
          // leading -> Navigator pop
          leading: TextButton.icon(onPressed: () => Navigator.pop(context), icon: Icon(FeatherIcons.chevronLeft, color: primaryLine,), label: Text(''))
        ),
        body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[UserInfo()]))));
  }
}
