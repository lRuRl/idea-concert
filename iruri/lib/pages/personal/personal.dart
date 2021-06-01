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
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: MyProfile(userData: user.currentUser),
                        ),
                      ],
                    ),
                  ),
                  subContainerWithTopBorder(personalCode(context, '123456789')),
                  subContainerWithTopBorder(managePortfolio()),
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

  Widget managePortfolio() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: 1,
          child: Text("포트폴리오 관리",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.left)),
      Expanded(
          flex: 1,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: themeLightGrayOpacity20),
                    child: TextFormField(
                      enabled: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: themeLightGrayOpacity20, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: themeLightGrayOpacity20, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: themeLightGrayOpacity20, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          fillColor: Colors.white,
                          labelStyle:
                              TextStyle(color: themeGrayText, fontSize: 13),
                          labelText: 'URL 또는 드라이브 링크'),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "조회",
                      style: buttonWhiteTextStyle,
                    ),
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

  Widget personalCode(BuildContext context, String code) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: 1,
          child: Text("고유코드 정보",
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
                  child: Center(
                      child: Text(
                    code,
                    style: articleTagTextStyle,
                  )),
                ),
                ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: code)).then(
                          (value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('클립보드로 복사되었습니다.'),
                              )));
                    },
                    child: Text("복사", style: buttonWhiteTextStyle),
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
