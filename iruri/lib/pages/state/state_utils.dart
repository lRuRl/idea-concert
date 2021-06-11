import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/provider.dart';
import 'package:iruri/util/data_article.dart';
import 'package:iruri/util/data_user.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iruri/pages/home/project_detail_components.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/typhography.dart';

// pages
import 'package:iruri/pages/state/state_applys.dart';

// article
import 'package:iruri/model/article.dart';
// provider
import 'package:provider/provider.dart';
// model
import 'package:iruri/model/article.dart';
import 'package:iruri/model/user.dart';

boxItem(int index, List<Container> items, BuildContext context, Article data) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  // size
  final size = MediaQuery.of(context).size;
  return Container(
      margin: marginH10V10,
      padding: paddingH10V10,
      width: size.width * 0.7,
      height: size.width * 0.45,
      decoration: BoxDecoration(
        border: Border.all(color: lightWhite, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 8,
              child: InkWell(
                onTap: () => routerReader.navigateTo(
                    routerWatcher.currentPage, '/state/projectdetail',
                    data: data),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: size.width * 0.25,
                          width: size.width * 0.35,
                          child: data.imagePath != null
                              ? ImageWrapper(image: data.image)
                              : Image.asset('assets/default.png'),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.37,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                'D-' +
                                    DateTime.parse(data.detail.dueDate)
                                        .difference(DateTime.now())
                                        .inDays
                                        .toString() +
                                    "  ",
                                style: articleDuedateTextStyle2),
                          ),
                          data.detail.content.title.length > 12
                              ? boldText2(data.detail.content.title)
                              : boldText(data.detail.content.title),
                          SizedBox(height: 3),
                          PositionSmallLinear(
                            data: data.detail.content.tags,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                    "승인대기중 : " + getUidList(data).length.toString() + '명',
                    style: articleWriterTextStyle)),
          ),
          // SizedBox(
          //   height: 4,
          // ),
          Expanded(flex: 3, child: listItemButton_my(context, data)),
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
          color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 3),
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

Widget applicant_vertical(BuildContext context, List<Container> items) {
  return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText16("  지원자 조회"),
              ],
            )),
        Expanded(
          flex: 10,
          child: myList_vertical(items),
        ),
        Expanded(flex: 1, child: Text('')),
      ]));
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

Widget boldText16(String txt) {
  return Text(txt, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}

Widget boldText(String txt) {
  return Text(txt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700));
}

Widget boldText2(String txt) {
  return Text(txt,
      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold));
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
            primary: primary,
            onPrimary: Colors.white,
          )),
      ElevatedButton(
          onPressed: () {},
          child: Text("완료된 프로젝트"),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
Widget listItemButton_my(BuildContext context, Article article) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  List<String> types = ["A형", "B형", "C형", "D형"];
  Contract contract = new Contract(types);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () {
            showMaterialModalBottomSheet(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              context: context,
              builder: (context) => SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                  child: UploadContract(contract: contract)),
            );
          },
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
            side: BorderSide(color: secondary, width: 1),
            onSurface: secondary,
            onPrimary: secondary,
          )),
      ElevatedButton(
          onPressed: () => routerReader.navigateTo(
              routerWatcher.currentPage, '/state/stateapplys',
              article: article),
          child: Row(
            children: [
              Icon(
                FeatherIcons.users,
                size: 14,
                color: secondary,
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
    // manageTeam(context),
  ]));
}

// Widget manageTeam(BuildContext context) {
//   return Container(
//       height: MediaQuery.of(context).size.height * 0.25,
//       width: MediaQuery.of(context).size.width * 1,
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: memberListSample.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: MediaQuery.of(context).size.width * 1,
//             margin: EdgeInsets.symmetric(vertical: 7),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Icon(
//                     Icons.remove_circle_outline,
//                     size: 20,
//                   ),
//                 ),
//                 Expanded(
//                     flex: 4,
//                     child: Container(
//                         alignment: Alignment.centerRight,
//                         height: 20,
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: List<Widget>.generate(
//                                 memberListSample[index].roles.length,
//                                 (indexs) => Container(
//                                       margin: EdgeInsets.only(left: 10),
//                                       child: TagWrapper(
//                                         onPressed: () {},
//                                         tag: memberListSample[index]
//                                             .roles[indexs],
//                                       ),
//                                     ))))),
//                 Expanded(
//                     flex: 5,
//                     child: nicknameEdit(
//                         "@" + memberListSample[index].info.nickname)),
//               ],
//             ),
//           );
//         },
//       ));
// }

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
        // showMyDialog(context, "저장이 완료되었습니다.", "");
        showcontractDialog(context)((result) {
          Navigator.pop(context);
        });
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
  final Article data;
  SelectBoxApply({this.data});
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
  void dispose() {
    super.dispose();
    selectedList.clear();
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
              child:
                  Icon(FeatherIcons.chevronDown, size: 24, color: Colors.grey),
            ),
            Text("업무 선택하기",
                style: notoSansTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: displayText)),
            divider,
            GroupedCheckbox(
              options: widget.data.detail.content.tags
                  .map((e) => FormBuilderFieldOption(value: e))
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
                  ArticleAPI()
                      .apply(widget.data.id, selectedList, 'tester', 'new')
                      .then((value) => showMyDialog(context, "신청이 완료 되었습니다.",
                          "자세한 지원 사항은 나의 페이지에서 확인 할 수 있습니다."))
                      .then((value) => Navigator.pop(context));
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

class Contract {
  final List<String> types;

  Contract(this.types);
}

class UploadContract extends StatefulWidget {
  final Contract contract;
  UploadContract({this.contract});
  @override
  _UploadContractState createState() => _UploadContractState();
}

class _UploadContractState extends State<UploadContract> {
  // for position selected
  List<String> selectedList;
  void onSelected(List<String> selected) => setState(() {
        selectedList = selected;
      });

  String currentmode;
  @override
  void initState() {
    super.initState();
    selectedList = [];
  }

  @override
  void dispose() {
    super.dispose();
    selectedList.clear();
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
        height: size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child:
                  Icon(FeatherIcons.chevronDown, size: 24, color: Colors.grey),
            ),
            Text("계약서 선택하기",
                style: notoSansTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: displayText)),
            divider,
            GroupedCheckbox(
              options: widget.contract.types
                  .map((e) => FormBuilderFieldOption(value: e))
                  .toList(),
              onChanged: onSelected,
              orientation: OptionsOrientation.wrap,
              activeColor: primary,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: Text("저장하기", style: buttonWhiteTextStyle),
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

class ContractContentElement extends StatefulWidget {
  List<bool> checkState = [false, false, false, false];

  List<bool> getCheckState() {
    return this.checkState;
  }

  @override
  _ContractContentElementState createState() => _ContractContentElementState();
}

class _ContractContentElementState extends State<ContractContentElement> {
  // List<bool> checkState;
  @override
  void initState() {
    widget.checkState = [false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        element(0, "전자서명 및 전자문서의 법적 효력에 대해 동의합니다."),
        element(1, "서명 완료 후 전송되는 전자문서를 원본으로\n인정합니다."),
        element(2, "모든 서명 참여자가 전자서명에 정당한 권한을\n가지는 것을 확인했습니다."),
        element(3, "기타 자세한 내용은 전자서명 이용약관에 따라\n 동의합니다. "),
      ],
    ));
  }

  Widget element(int index, String str) {
    return Row(
      children: [
        InkWell(
          splashColor: Color.fromRGBO(0, 0, 0, 0),
          onTap: () {
            index == 3
                ? showDetailSignElementDialog(context).then((result) {
                    setState(() {
                      widget.checkState[3] = true;
                    });
                  })
                : setState(() {
                    widget.checkState[index] = !widget.checkState[index];
                  });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.checkState[index]
                    ? themeLightOrange
                    : Color.fromRGBO(0xee, 0xee, 0xee, 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: widget.checkState[index]
                  ? Icon(
                      Icons.check,
                      size: 17.0,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.circle,
                      size: 17.0,
                      color: Color.fromRGBO(0xee, 0xee, 0xee, 1),
                    ),
            ),
          ),
        ),
        index == 3
            ? openToS(context)
            : Text(str,
                softWrap: true,
                style: notoSansTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    textColor: Color.fromRGBO(0x4f, 0x4f, 0x4f, 1)))
      ],
    );
  }

  Widget openToS(BuildContext context) {
    return Row(
      children: [
        Text('기타 자세한 내용은 \n동의합니다.',
            softWrap: true,
            style: notoSansTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                textColor: Color.fromRGBO(0x4f, 0x4f, 0x4f, 1))),
        InkWell(
            onTap: () => {
                  showDetailSignElementDialog(context).then((result) {
                    setState(() {
                      widget.checkState[3] = true;
                    });
                  })
                },
            child: Text('전자서명 이용약관\n',
                softWrap: true,
                style: TextStyle(
                    fontSize: 12.5,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0x4f, 0x4f, 0x4f, 1)))),
        Text('에 따라\n',
            // softWrap: true,
            style: notoSansTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                textColor: Color.fromRGBO(0x4f, 0x4f, 0x4f, 1))),
      ],
    );
  }
}

containerApplys(int index, BuildContext context, User data, Article article) {
  // provider
  final routerReader = context.read<CustomRouter>();
  final routerWatcher = context.watch<CustomRouter>();
  Article articleData = routerReader.article;
  return Container(
      margin: EdgeInsets.symmetric(
        // horizontal: 10,
        vertical: 2,
      ),
      height: 210,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
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
                        routerWatcher.currentPage,
                        '/state/stateapplys/personal',
                        data: data,
                        article: routerWatcher.article),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: data.image != null
                              ? ImageWrapper(image: data.imageChunk)
                              : Image.asset('assets/default.png'),

                          // child: Image.asset('assets/default.png'),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => routerReader.navigateTo(
                          routerWatcher.currentPage,
                          '/state/stateapplys/personal',
                          data: data,
                          article: routerWatcher.article),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: 210,
                        height: 140,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                boldText(
                                  data.profileInfo.name,
                                ),
                                InkWell(
                                  onTap: () => routerReader.navigateTo(
                                      routerWatcher.currentPage,
                                      '/state/stateapplys/personal',
                                      data: data,
                                      article: routerWatcher.article),
                                  child:
                                      Icon(FeatherIcons.chevronRight, size: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SizedBox(
                                //   width: 8,
                                // ),
                                Container(
                                  // color: Colors.black,
                                  alignment: Alignment.centerRight,
                                  width: data.getApplyRoles(article).length *
                                          50.0 +
                                      8,
                                  child: PositionSmallLinear(
                                      data: data.getApplyRoles(article)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    data.profileInfo.location == null
                                        ? '지역 : 미작성'
                                        : "지역 : " + data.profileInfo.location,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                        color: Color.fromRGBO(
                                            0x77, 0x77, 0x77, 1))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child:
                                Text(
                                    data.profileInfo.genres?.isEmpty ?? true
                                        ? '선호 장르 : 미작성'
                                        : '선호 장르 : ' +
                                            getGenreList(
                                                data.profileInfo.genres),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                        color: Color.fromRGBO(
                                            0x77, 0x77, 0x77, 1)),
                                            overflow: TextOverflow.visible)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    data.profileInfo.career == null
                                        ? '경력 : 미작성'
                                        : '경력 : ' +
                                            data.profileInfo.career +
                                            '년 이상',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                        color: Color.fromRGBO(
                                            0x77, 0x77, 0x77, 1))),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    width: 1.5,
                    color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1),
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 210 / 5,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1),
                                ))),
                                child: boldText(
                                  '승인 수락',
                                )),
                            onTap: () {
                              ArticleAPI()
                                  .applyStateUpdate(
                                      articleData.id,
                                      data.getApplyRoles(article),
                                      data.uid,
                                      'confirm')
                                  .then((value) => showMyDialog(
                                      context, "승인이 수락되었습니다. ", ""));
                            },
                          )),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            height: 210 / 5,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: boldText(
                              '승인 거절',
                            ),
                          ),
                          onTap: () {
                            ArticleAPI()
                                .applyStateUpdate(
                                    articleData.id,
                                    data.getApplyRoles(article),
                                    data.uid,
                                    'delete')
                                .then((value) =>
                                    showMyDialog(context, "승인이 거절되었습니다. ", ""));
                          },
                        ),
                      )
                    ],
                  ))),
        ],
      ));
}

String getGenreList(List<String> genres) {
  String result = '';
  for (int i = 0; i < genres.length; i++) {
    result += genres[i];
    if (i != genres.length - 1) {
      result += '/';
    }
  }
  return result;
}

List<Widget> rolesLinearTag(List<String> roles) {
  Widget element;
  for (int i = 0; i < roles.length; i++) {
    // element =
    // PositionSmallLinear()
  }
}

List<String> getUidList(Article article) {
  List<String> uidList = [];

  if (article.detail.applicant.drawAfters?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawAfters.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawAfters[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawAfters[i].uid);
    }
  }

  if (article.detail.applicant.drawColors?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawColors.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawColors[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawColors[i].uid);
    }
  }

  if (article.detail.applicant.drawChars?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawChars.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawChars[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawChars[i].uid);
    }
  }

  if (article.detail.applicant.drawLines?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawLines.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawLines[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawLines[i].uid);
    }
  }

  if (article.detail.applicant.drawDessins?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawDessins.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawDessins[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawDessins[i].uid);
    }
  }

  if (article.detail.applicant.drawContis?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawContis.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawContis[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawContis[i].uid);
    }
  }

  if (article.detail.applicant.drawMains?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawMains.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawMains[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawMains[i].uid);
    }
  }

  if (article.detail.applicant.writeMains?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.writeMains.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.writeMains[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.writeMains[i].uid);
    }
  }

  if (article.detail.applicant.writeContis?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.writeContis.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.writeContis[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.writeContis[i].uid);
    }
  }
  return uidList;
}
