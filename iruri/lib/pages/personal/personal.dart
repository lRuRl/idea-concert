import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  ScrollController scrollController = new ScrollController();

  var mobileID;

  @override
  Widget build(BuildContext context) {
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
                    child: personalInfo(),
                  ),
                  Container(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: introduction(),
                  )
                ],
              ),
            ),
            Container(
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
              child: personalCode(),
            ),
            Container(
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
              child: managePortfolio(),
            ),
            logout()
          ],
        ),
      ),
    );
  }

  Future<String> getMobileID() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String id = '';
    try {
      if (Platform.isAndroid) {
        //안드로이드 기기의 경우
        final AndroidDeviceInfo androidData =
            await deviceInfoPlugin.androidInfo; //androidInfo를 가져옴
        id = androidData.androidId;
      } else if (Platform.isIOS) {
        //IOS의 경우
        final IosDeviceInfo iosData =
            await deviceInfoPlugin.iosInfo; //iosInfo를 가져옴
        id = iosData.identifierForVendor;
      }
    } on PlatformException {
      id = '';
    }
    return id;
  }

  @override
  initState() {
    super.initState();
    mobileID = getMobileID();
  }

  //unique ID 생성 (기기의 고유식별번호(uuid) 이용)
  Widget introduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text("자기소개",
                style: TextStyle(fontWeight: FontWeight.w700),
                textAlign: TextAlign.left)),
        Expanded(
            flex: 7,
            child: TextFormField(
              // TODO: 수정할 때 true
              enabled: false,
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: themeLightGrayOpacity20, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: themeGrayText, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: themeGrayText, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: themeGrayText),
                  labelText: '자기소개를 입력하세요.'),
            ))
      ],
    );
  }

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
                    child: Text("조회", style: buttonWhiteTextStyle,),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(12),
                      primary: themeDeepBlue,
                      onPrimary: Colors.white,
                    )),
              ]))
    ]);
  }

  Widget personalCode() {
    return FutureBuilder(
        future: mobileID,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError)
            return Center(child: CircularProgressIndicator());
          final size = MediaQuery.of(context).size;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              //"CHBH12387DNJ13",
                              snapshot.data, //mobileID 변수에 받아온 ID를 출력
                              style: articleTagTextStyle,
                            )),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(
                                        new ClipboardData(text: snapshot.data))
                                    .then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('클립보드로 복사되었습니다.'),
                                        )));
                              },
                              child: Text("복사", style: buttonWhiteTextStyle),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.all(12),
                                primary: themeDeepBlue,
                                onPrimary: Colors.white,
                              )),
                        ]))
              ]);
        });
  }

  Widget personalInfo() {
    return Container(
      child: MyProfile(),
    );
  }
}
