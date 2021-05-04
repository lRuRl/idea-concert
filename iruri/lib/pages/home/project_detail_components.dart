import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';

Widget thumbnail(BuildContext context, Article data) {
  return Image.network(
    data.detail.content.imagePath,
    alignment: Alignment.center,
    errorBuilder: (context, error, stackTrace) =>
        Icon(Icons.error_outline_rounded, size: 24, color: themeGrayText),
    fit: BoxFit.fill,
  );
}

Widget noticeDetail(BuildContext context, Article data) {
  return Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("공고 상세보기",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.left),
      Align(
        alignment: Alignment.centerRight,
        child: Position_Small(),
      ),
      Text(data.detail.content.title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
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
                      'D' +
                          DateTime.now()
                              .difference(data.detail.dueDate)
                              .inDays
                              .toString(),
                      style: articleDuedateTextStyle)
                ]),
                Text(data.detail.writer, style: articleWriterTextStyle),
              ],
            )),
      )
    ]),
  );
}

Widget projectCalendar(BuildContext context, Article data) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("프로젝트 일정",
        style: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          customBox(context,
              "${data.detail.periods[0].month.toString()}월 ${data.detail.periods[0].day.toString()}일"),
          Text(
              "${data.detail.periods[1].difference(data.detail.periods[0]).inDays.toString()}일",
              style: articleDuedateTextStyle),
          customBox(context,
              "${data.detail.periods[1].month.toString()}월 ${data.detail.periods[1].day.toString()}일"),
        ]))
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

Widget applyButton(){
  return ElevatedButton(
          onPressed: () {},
          child: Text("지원하기",
              style: TextStyle(
                fontSize: 12,
              )),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            //fixedSize: Size(90, 30),
            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
            onPrimary: Colors.white,
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
