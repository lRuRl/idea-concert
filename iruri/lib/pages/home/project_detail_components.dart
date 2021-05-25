import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:iruri/pages/state/state_utils.dart';

Widget thumbnail(BuildContext context, Article data) {
  return Image.memory(
    base64Decode(data.image),
    alignment: Alignment.center,
    errorBuilder: (context, error, stackTrace) =>
        Icon(Icons.error_outline_rounded, size: 24, color: themeGrayText),
    fit: BoxFit.cover,
  );
}

Widget noticeDetail(BuildContext context, Article data) {
  return Container(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 10,
            children: [
              Text(data.detail.content.title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 2 / 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10),
                itemCount: data.detail.content.tags.length,
                itemBuilder: (context, index) =>
                    TagWrapper(tag: data.detail.content.tags[index]),
              )
            ],
          ),
          // Position_Small_Linear(),
          Row(
            children: [
              Text(data.detail.writer + " | ",
                  style: TextStyle(
                      color: Color.fromRGBO(0x00, 0x00, 0x00, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 11)),
              Text(data.detail.location,
                  style: TextStyle(
                      color: Color.fromRGBO(0x77, 0x77, 0x77, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 11)),
            ],
          ),
          Text(data.detail.content.genres.join(' · '),
              style: TextStyle(
                  color: Color.fromRGBO(0x77, 0x77, 0x77, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 11)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0xff, 0xff, 0xff, 1),
                  border:
                      Border.all(color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.heart,
                      size: 14,
                    ),
                    Text(
                      " 30 ",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Text>[
                          Text('마감일 ', style: articleWriterTextStyle),
                          Text(
                              'D-DAY ' +
                                  DateTime.parse(data.detail.dueDate)
                                      .difference(DateTime.now())
                                      .inDays
                                      .toString(),
                              style: articleDuedateTextStyle)
                        ]),
                      ],
                    )),
              )
            ],
          )
        ]),
  );
}

Widget projectCalendar(BuildContext context, Article data) {
  final begin = DateTime.parse(data.detail.period.from);
  final end = DateTime.parse(data.detail.period.to);

  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(
      flex: 2,
      child: Text("모집 조건",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.left),
    ),
    Expanded(
        flex: 5,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.edit,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "전자 서명",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.penTool,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      // "6개월 ~ 1년",
                      (end.difference(begin).inDays ~/ 30).toString() + ' 개월',
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.calendar,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "월 ~ 금",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.clock,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "탄력 근무제",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
              ],
            )))
  ]));
}

Widget projectDetailContent(BuildContext context, Article data) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("프로젝트 상세 내용",
        style: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left),
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(data.detail.content.desc))
  ]));
}

Widget applyButton(BuildContext context, String mode, Article data) {
  final size = MediaQuery.of(context).size;
  String currentmode = mode;
  return ElevatedButton(
      onPressed: () {
        // showMyDialog(
        //     context, "신청이 완료 되었습니다.", "자세한 지원 사항은 나의 페이지에서 확인 할 수 있습니다.");

        showMaterialModalBottomSheet(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          context: context,
          builder: (context) => SingleChildScrollView(
              // padding: EdgeInsets.only(bottom: 55),
              controller: ModalScrollController.of(context),
              child: SelectBoxApply(tags: data.detail.content.tags,)),
        );
      },
      child: Text("지원하기",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(top: 11, bottom: 11, left: 11, right: 11),
        //fixedSize: Size(90, 30),
        primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
        onPrimary: Colors.white,
      ));
}

Widget scrapButton() {
  return ElevatedButton(
      onPressed: () {},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.turned_in_not, size: 20),
            Text("스크랩",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
        //fixedSize: Size(90, 30),
        primary: Colors.white,
        side: BorderSide(color: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1), width: 1),
        onSurface: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
        onPrimary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
      ));
}

Widget customBox(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;

  return Container(
    width: size.width * 0.3,
    height: size.height * 0.08,
    decoration: BoxDecoration(
      color: Color.fromRGBO(196, 196, 196, 0.13),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Center(child: Text(text, textAlign: TextAlign.center)),
  );
}

showMyDialog(BuildContext context, String str1, String str2) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        elevation: 5.0,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height / 3.5,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(FeatherIcons.checkCircle,
                      size: 45, color: Color.fromRGBO(0xFF, 0x94, 0x3a, 1)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        str1,
                        style: TextStyle(
                            color: Color.fromRGBO(0x16, 0x16, 0x16, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Text(""),
                      Text(
                        str2,
                        style: TextStyle(
                            color: Color.fromRGBO(0x67, 0x67, 0x67, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("확인",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 4),

                          //fixedSize: Size(90, 30),
                          primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                          onPrimary: Colors.white,
                        )))
              ],
            )),
      );
    },
  );
}
