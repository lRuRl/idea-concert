import 'package:flutter/material.dart';
import 'dart:io'; // for image

/// [todo] change to objectid
import 'package:provider/provider.dart';
// components
import 'package:flutter/services.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/provider.dart';
// pages
import 'package:iruri/pages/personal/personal_detail.dart';
// api
import 'package:iruri/util/data_user.dart' as API;

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserState>();
    if (user.currentUser != null) {
      return Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              MyProfile(userData: user.currentUser),
              subContainerWithTopBorder(subComponentDetail(
                  context: context,
                  onPressed: () => Clipboard.setData(
                          new ClipboardData(text: user.currentUser.uid))
                      .then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('클립보드로 복사되었습니다.'),
                          ))),
                  child:
                      Text(user.currentUser.uid, style: articleWriterTextStyle),
                  name: '고유코드 정보',
                  btnName: '복사')),
              subContainerWithTopBorder(subComponentDetail(
                  context: context,
                  onPressed: () => print('portfolio'),
                  child: Text(
                      user.currentUser.portfolio.substring(
                          user.currentUser.portfolio.indexOf('-') + 1),
                      style: articleWriterTextStyle),
                  name: '포트폴리오 관리',
                  btnName: '조회')),
              logout()
            ],
          ),
        ),
      );
    } else {
      return Center(child: Text('사용자정보가 없습니다.'));
    }
  }

  Container subContainerWithTopBorder(Widget child) => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.12,
        child: child,
      );

  Widget logout() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width * 1,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.blue,
            onSurface: Colors.red,
          ),
          onPressed: () => Provider.of<CustomRouter>(context, listen: false)
              .setRegistrationStatus(false),
          child: Text('로그아웃', style: TextStyle(color: greyText)),
        ));
  }

  Widget subComponentDetail(
      {BuildContext context,
      Function onPressed,
      Widget child,
      String name,
      String btnName}) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: 1,
          child: Text(name,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.left)),
      Expanded(
          flex: 1,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.7,
                  padding: paddingH6V4,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: themeLightGrayOpacity20,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: themeLightGrayOpacity20),
                  child: Center(child: child),
                ),
                ElevatedButton(
                    onPressed: onPressed,
                    child: Text(btnName, style: buttonWhiteTextStyle),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(12),
                      primary: themeDeepBlue,
                      onPrimary: Colors.white,
                    )),
              ]))
    ]);
  }
}
