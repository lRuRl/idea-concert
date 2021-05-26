import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iruri/pages/home/project_detail_components.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/typhography.dart';

// article
import 'package:iruri/model/article.dart';

// member
import 'package:iruri/model/member_sample.dart';
// provider
import 'package:provider/provider.dart';
// model
import 'package:iruri/model/article.dart';

boxItem(int index, List<Container> items, BuildContext context, Article data) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  // size
  final size = MediaQuery.of(context).size;
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      width: size.width * 0.7,
      height: size.width * 0.5,
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
                  GestureDetector(
                    onTap: () => routerReader.navigateTo(
                        routerWatcher.currentPage, '/state/projectdetail',
                        data: data),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 86,
                          width: 86,
                          child: data.imagePath != null
                              ? ImageWrapper(image: data.image)
                              : Image.asset('assets/default.png'),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => routerReader.navigateTo(
                          routerWatcher.currentPage, '/state/projectdetail',
                          data: data),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.width * 0.25,
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                data.detail.content.title.length > 12
                                    ? boldText2(data.detail.content.title)
                                    : boldText(data.detail.content.title),
                              ],
                            ),
                            /// TODO: [ DB 연동하기 ]
                            Text(
                                "승인대기중 : " +
                                    // data.detail.applicants.length.toString() +
                                    "2명",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Roboto",
                                    color:
                                        Color.fromRGBO(0x77, 0x77, 0x77, 1))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("모집 부분",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                        color: Color.fromRGBO(
                                            0x77, 0x77, 0x77, 1))),
                                Text(
                                    'D-' +
                                        DateTime.parse(data.detail.dueDate)
                                            .difference(DateTime.now())
                                            .inDays
                                            .toString() +
                                        "  ",
                                    style: articleDuedateTextStyle2),
                              ],
                            ),
                            Row(
                              children: [Position_Small()],
                            )
                          ],
                        ),
                      )),
                ],
              )),
          Expanded(flex: 2, child: listItemButton_my(context))
        ],
      ));
}

boxItem_apply(
    int index, List<Container> items, BuildContext context, Article data) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      height: 210,
      width: 289,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => routerReader.navigateTo(
                        routerWatcher.currentPage, '/state/projectdetail',
                        data: data),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 86,
                          width: 86,
                          child: data.imagePath != null
                              ? ImageWrapper(image: data.image)
                              : Image.asset('assets/default.png'),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => routerReader.navigateTo(
                          routerWatcher.currentPage, '/state/projectdetail',
                          data: data),
                      child: Container(
                        width: 150,
                        height: 105,
                        color: Colors.white,
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
                              ],
                            ),
                            data.detail.content.title.length > 12
                                ? boldText2(data.detail.content.title)
                                : boldText(data.detail.content.title),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("지원한 부분",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                        color: Color.fromRGBO(
                                            0x77, 0x77, 0x77, 1))),
                                Text(
                                    'D-' +
                                        DateTime.parse(data.detail.dueDate)
                                            .difference(DateTime.now())
                                            .inDays
                                            .toString() +
                                        "  ",
                                    style: articleDuedateTextStyle2),
                              ],
                            ),
                            Row(
                              children: [Position_Small()],
                            )
                          ],
                        ),
                      ))
                ],
              )),
          Expanded(flex: 2, child: listItemButton(context, data))
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

Widget boldText2(String txt) {
  return Text(txt,
      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold));
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            primary: primary,
            onPrimary: Colors.white,
          )),
      ElevatedButton(
          onPressed: () {},
          child: Text("완료된 프로젝트"),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

//내가 지원한 프로젝트 (아래)
Widget listItemButton(BuildContext context, Article data) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () => routerReader.navigateTo(
              routerWatcher.currentPage, '/state/fillcontract', data: data),
          child: Text("계약서 작성",
              style: TextStyle(
                  fontSize: 12, color: Color.fromRGBO(0x1b, 0x30, 0x59, 1))),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 92),
            elevation: 0,
            //fixedSize: Size(90, 30),
            primary: Colors.white,
            side: BorderSide(
                color: Color.fromRGBO(0x1b, 0x30, 0x59, 1), width: 1),
            onSurface: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
            onPrimary: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
          )),
    ],
  );
}

//내가 올린 프로젝트 (위)
Widget listItemButton_my(BuildContext context) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                FeatherIcons.upload,
                size: 14,
                color: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
              ),
              Text("  계약서 업로드",
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            elevation: 1,
            //fixedSize: Size(90, 30),
            primary: Colors.white,
            side: BorderSide(
                color: Color.fromRGBO(0x1b, 0x30, 0x59, 1), width: 1),
            onSurface: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
            onPrimary: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
          )),
      ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                FeatherIcons.users,
                size: 14,
                color: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
              ),
              Text("  신청자 조회",
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            elevation: 1,
            //fixedSize: Size(90, 30),
            primary: Colors.white,
            side: BorderSide(
                color: Color.fromRGBO(0x1b, 0x30, 0x59, 1), width: 1),
            onSurface: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
            onPrimary: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
          )),
      // ElevatedButton(
      //     onPressed: () => routerReader.navigateTo(
      //           routerWatcher.currentPage,
      //           '/state/projectdetail',
      //         ),
      //     child: Text("팀원 조회",
      //         style: TextStyle(
      //           fontSize: 12,
      //         )),
      //     style: ElevatedButton.styleFrom(
      //       padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
      //       // fixedSize: Size(90, 30),
      //       primary: Color.fromRGBO(0x1B, 0x30, 0x59, 1),
      //       onPrimary: Colors.white,
      //     ))
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
    Expanded(flex: 8, child: myList(items)),
    Expanded(flex: 1, child: SizedBox()),
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
    Expanded(flex: 8, child: myList_vertical(items)),
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

Widget contractTitle(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("계약서 작성",
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.left),
      ]));
}

Widget saveContractButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        showMyDialog(context, "저장이 완료되었습니다.", "");
      },
      child: Text("계약서 저장하기",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(top: 11, bottom: 11, left: 11, right: 11),
        //fixedSize: Size(90, 30),
        primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
        onPrimary: Colors.white,
      ));
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

class SelectBoxApply extends StatefulWidget {
  final List<String> tags;
  SelectBoxApply({this.tags});
  @override
  _SelectBoxApplyState createState() => _SelectBoxApplyState();
}

class _SelectBoxApplyState extends State<SelectBoxApply> {
  // for position selected
  List<String> selectedList;
  void onSelected(List<String> selected) => setState(() {
    selectedList = selected;
  });

  String currentmode;
  @override
  void initState() {
    super.initState();
    currentmode = 'user';
    // selected List
    selectedList = [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        width: size.width * 1,
        height: size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(FeatherIcons.chevronDown, size: 24, color: Colors.grey),
            ),
            Text("업무 선택하기",
                  style: notoSansTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: displayText)),
            divider,
            GroupedCheckbox(
              options: widget.tags
                  .map((e) => FormBuilderFieldOption(
                    value: e))
                  .toList(),
              onChanged: onSelected,
              orientation: OptionsOrientation.wrap,
              activeColor: primary,
            ),
            divider,
            // PositionSmallLinear(data: widget.tags, onSelected: onSelected,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // made space using wrap
                Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentmode = 'user';
                            });
                          },
                          child: Icon(
                            FeatherIcons.user,
                            size: 44,
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              side: BorderSide(
                                  color: Color.fromRGBO(0xe0, 0xe0, 0xe0, 1),
                                  width: 0.5),
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                              //fixedSize: Size(90, 30),
                              primary: currentmode == 'user'
                                  ? primary
                                  : Colors.white,
                              onPrimary: currentmode == 'users'
                                  ? primary
                                  : Colors.white)),
                      Text("개인",
                          style: notoSansTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: displayText)),
                    ]),
                // made space using wrap
                Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentmode = 'users';
                            });
                          },
                          child: Icon(
                            FeatherIcons.users,
                            size: 44,
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              side: BorderSide(
                                  color: Color.fromRGBO(0xe0, 0xe0, 0xe0, 1),
                                  width: 0.5),
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                              //fixedSize: Size(90, 30),
                              primary: currentmode == 'users'
                                  ? primary
                                  : Colors.white,
                              onPrimary: currentmode == 'user'
                                  ? primary
                                  : Colors.white)),
                      Text("그룹",
                          style: notoSansTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: displayText)),
                    ]),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  showMyDialog(context, "신청이 완료 되었습니다.",
                      "자세한 지원 사항은 나의 페이지에서 확인 할 수 있습니다.");
                },
                child: Text("지원하기", style: buttonWhiteTextStyle),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 2 - 48, vertical: 8),
                    backgroundColor: primary)),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
