import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// article
import 'package:iruri/model/article.dart';
import 'package:iruri/model/article_sample.dart';

// member
import 'package:iruri/model/member.dart';
import 'package:iruri/model/member_sample.dart';
// provider
import 'package:provider/provider.dart';

boxItem(int index, List<Container> items, BuildContext context) {
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 200,
      width: 279,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment(0, 0),
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(196, 196, 196, 0.13),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Center(child: Text("썸네일")),
                  ),
                  Container(
                    width: 150,
                    height: 90,
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            boldText("그림 작가 모집"),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        Text("승인대기중 : 3명",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Roboto",
                                color: Color.fromRGBO(0x77, 0x77, 0x77, 1))),
                        Text("모집 부분",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Roboto",
                                color: Color.fromRGBO(0x77, 0x77, 0x77, 1))),
                        Row(
                          children: [Position_Small()],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Expanded(flex: 2, child: listItemButton(context))
        ],
      ));
}

boxItem_apply(int index, List<Container> items, BuildContext context) {
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 200,
      width: 279,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment(0, 0),
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(196, 196, 196, 0.13),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Center(child: Text("썸네일")),
                  ),
                  Container(
                    width: 150,
                    height: 90,
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ApprovalState(
                              stateIndex: index % 3,
                            ),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        boldText("메인 그림 작가 모집 !"),
                        Text("지원한 부분",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Roboto",
                                color: Color.fromRGBO(0x77, 0x77, 0x77, 1))),
                        Row(
                          children: [Position_Small()],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Expanded(flex: 2, child: listItemButton(context))
        ],
      ));
}

Widget myList(List<Container> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (context, index) {
      return items[index];
    },
  );
}

Widget myList_vertical(List<Container> items) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    itemBuilder: (context, index) {
      return items[index];
    },
  );
}

Widget applyProject(BuildContext context, List<Container> items) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();

  return Column(children: [
    Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText("내가 지원한 프로젝트 "),
            IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (BuildContext context) => ApplyListPage(),
                //     ));
                // use Provider - updated 04.12.21 by seunghwanly
                routerReader.navigateTo(
                    routerWatcher.currentPage, '/state/applylist');
              },
              icon: Icon(Icons.chevron_right, size: 30),
            )
          ],
        )),
    Expanded(
      flex: 4,
      child: myList(items),
    ),
    Expanded(flex: 1, child: Text('')),
  ]);
}

Widget applyProject_vertical(BuildContext context, List<Container> items) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText("내가 지원한 프로젝트 "),
              ],
            )),
        Expanded(
          flex: 10,
          child: myList_vertical(items),
        ),
        Expanded(flex: 1, child: Text('')),
      ]));
}

Widget boldText(String txt) {
  return Text(txt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700));
}

Widget selectButton() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
          onPressed: () {},
          child: Text("진행중인 프로젝트"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
            onPrimary: Colors.white,
          )),
      ElevatedButton(
          onPressed: () {},
          child: Text("완료된 프로젝트"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            primary: Colors.white,
            onPrimary: Color.fromRGBO(0x82, 0x82, 0x82, 1),
            // fixedSize: Size(90, 30),
          ))
    ],
  );
}

Widget saveButton() {
  return ElevatedButton(
      onPressed: () {},
      child: Text("저장하기",
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

Widget editButton() {
  return ElevatedButton(
      onPressed: () {},
      child: Text("수정",
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
        //fixedSize: Size(90, 30),
        primary: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
        onPrimary: Colors.white,
      ));
}

Widget listItemButton(BuildContext context) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () => routerReader.navigateTo(
                routerWatcher.currentPage,
                '/state/fillcontract',
              ),
          child: Text("계약서 작성",
              style: TextStyle(
                fontSize: 12,
              )),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            //fixedSize: Size(90, 30),
            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
            onPrimary: Colors.white,
          )),
      ElevatedButton(
          onPressed: () => routerReader.navigateTo(
                routerWatcher.currentPage,
                '/state/projectdetail',
              ),
          child: Text("팀원 조회",
              style: TextStyle(
                fontSize: 12,
              )),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            // fixedSize: Size(90, 30),
            primary: Color.fromRGBO(0x1B, 0x30, 0x59, 1),
            onPrimary: Colors.white,
          ))
    ],
  );
}

Widget myProject(BuildContext context, List<Container> items) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();

  return Column(children: [
    Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText("내가 올린 프로젝트 "),
            IconButton(
              onPressed: () => routerReader.navigateTo(
                  routerWatcher.currentPage, '/state/myproject'),
              icon: Icon(Icons.chevron_right, size: 30),
            )
          ],
        )),
    Expanded(flex: 4, child: myList(items)),
    Expanded(flex: 1, child: Text('')),
  ]);
}

Widget myProject_vertical(BuildContext context, List<Container> items) {
  return Column(children: [
    Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText("내가 올린 프로젝트 "),
          ],
        )),
    Expanded(flex: 10, child: myList_vertical(items)),
    Expanded(flex: 1, child: Text('')),
  ]);
}

Widget stateprojectDetailContent(BuildContext context, Article data) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("팀원 관리",
        style: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left),
    manageTeam(context),
  ]));
}

Widget manageTeam(BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 1,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: memberListSample.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 1,
            margin: EdgeInsets.symmetric(vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.remove_circle_outline,
                    size: 20,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                        alignment: Alignment.centerRight,
                        height: 20,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List<Widget>.generate(
                                memberListSample[index].roles.length,
                                (indexs) => Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: TagWrapper(
                                        onPressed: () {},
                                        tag: memberListSample[index]
                                            .roles[indexs],
                                      ),
                                    ))))),
                Expanded(
                    flex: 5,
                    child: nicknameEdit(
                        "@" + memberListSample[index].info.nickname)),
              ],
            ),
          );
        },
      ));
}

Widget nicknameEdit(String nickname) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(0xF2, 0xF2, 0xF2, 1)),
      child: Row(
        children: [
          Expanded(
            child: Text(nickname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                )),
            flex: 4,
          ),
          Expanded(
            child: Container(child: editButton()),
            flex: 1,
          )
        ],
      ));
}

Widget contractDetail(BuildContext context, Article data, String pathPDF) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("계약서 작성",
        style: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left),
    Padding(
        padding: const EdgeInsets.all(10.0), child: contractContent(data, 1, pathPDF))
  ]));
}

Widget contractContent(Article data, int index, String pathPDF) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("계약서 조항 ($index)",
        style: TextStyle(fontWeight: FontWeight.normal),
        textAlign: TextAlign.left),
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: PDFView(
          filePath: pathPDF,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          fitPolicy: FitPolicy.BOTH,
       
        ))
  ]));
  // <key>io.flutter.embedded_views_preview</key> --> iOS에서 Info.plist에 추가
}

Future<File> createFileOfPdfUrl() async {
  Completer<File> completer = Completer();
  try {
    final url = "http://www.africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");

    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}

Future<File> fromAsset(String asset, String filename) async {
  // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  Completer<File> completer = Completer();

  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}
