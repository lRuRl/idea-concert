import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:flutter/services.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  ScrollController scrollController = new ScrollController();

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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.43,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: personalInfo(),
                  ),
                  Container(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.30,
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.10,
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.10,
              child: managePortfolio(),
            ),
          ],
        ),
      ),
    );
  }

  Widget personalInfo() {
    return Container(
      child: Text("PERSONAL INFO CONTAINER"),
    );
  }

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
                          color: themeLightGrayOpacity20, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: themeGrayText, width: 1)),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: themeGrayText, width: 1)),
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: themeGrayText),
                  labelText: '자기소개를 입력하세요.'),
            ))
      ],
    );
  }

  Widget personalCode() {
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
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: themeLightGrayOpacity20,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: themeLightGrayOpacity20),
                  child: Center(
                      child: Text(
                    "CHBH12387DNJ13",
                    style: TextStyle(
                        color: themeGrayText, fontWeight: FontWeight.w800),
                  )),
                ),
                ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                          new ClipboardData(text: "CHBH12387DNJ13"));
                    },
                    child: Text("복사"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(3),
                      primary: themeDeepBlue,
                      onPrimary: Colors.white,
                    )),
              ]))
    ]);
  }

  Widget managePortfolio() {
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
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: themeLightGrayOpacity20,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: themeLightGrayOpacity20),
                  child: Center(
                      child: Text(
                    "URL 또는 드라이브 링크",
                    style: TextStyle(
                        color: themeGrayText, fontWeight: FontWeight.w800),
                  )),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("조회"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(3),
                      primary: themeDeepBlue,
                      onPrimary: Colors.white,
                    )),
              ]))
    ]);
  }
}
