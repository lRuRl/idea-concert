import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iruri/model/user.dart';
import 'dart:io'; // for image
import 'dart:async';
import 'dart:convert';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
    final router = context.watch<CustomRouter>();
    
    /// [view user] in list applicant -> specific user
    if (router.data.runtimeType == User) {
      User others = router.data;
      return Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              MyProfile(userData: router.data),
              subContainerWithTopBorder(subComponentDetail(
                  context: context,
                  onPressed: () => Clipboard.setData(
                          new ClipboardData(text: router.data.uid))
                      .then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('클립보드로 복사되었습니다.'),
                          ))),
                  child: Text(router.data.uid, style: articleWriterTextStyle),
                  name: '고유코드 정보',
                  btnName: '복사')),
              subContainerWithTopBorder(subComponentDetail(
                  context: context,
                  onPressed: () =>
                      showPDFDialog(context, others.portfolioChunk),
                  child: Text(
                      router.data.portfolio != null
                          ? router.data.portfolio
                              .substring(router.data.portfolio.indexOf('-') + 1)
                          : '정보가 없습니다.',
                      style: articleWriterTextStyle),
                  name: '포트폴리오 관리',
                  btnName: '조회')),
              logout()
            ],
          ),
        ),
      );
    }
    /// view information of [currentUser] the user who has signed-in now
    if (user.currentUser != null) {
      UserState userState = context.watch<UserState>();
      String portfolio = userState.currentUser.portfolioChunk;
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
                  onPressed: () => showPDFDialog(context, portfolio),
                  child: Text(
                      user.currentUser.portfolio != null
                          ? user.currentUser.portfolio.substring(
                              user.currentUser.portfolio.indexOf('-') + 1)
                          : '정보가 없습니다.',
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

  /// the viewer of [portfolio] which is uploaded in Database
  /// [context] for using dialog
  /// [base64] is used for buffer which is downloaded from server
  showPDFDialog(BuildContext context, String base64) {
    // encode to Unit8List
    Uint8List bytes = base64Decode(base64);

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Colors.white,
            elevation: 2.0,
            child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.7,
                // padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: PDFView(
                          pdfData: bytes,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: true,
                          pageSnap: true,
                          fitPolicy: FitPolicy.BOTH,
                        ),
                      )
                    ])));
      },
    );
  }
  /// set Component with lightWhite border at the top
  /// border color is set to [lightWhite]
  Container subContainerWithTopBorder(Widget child) => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 5, color: lightWhite),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.12,
        child: child,
      );
  
  /// the functional component with [TextButton]
  /// using [Provider] of CustomRouter to set current user sign-out
  /// when using Provider outside of context, [listen] property must be set to false
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
  /// [context] for using MediaQuery 
  /// [onPressed] for ElevatedButton
  /// [child] for dynamic Component
  /// [name] for Header Title
  /// [btnName] for Elevated Button
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
