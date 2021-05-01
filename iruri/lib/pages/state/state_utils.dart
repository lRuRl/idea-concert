import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/provider.dart';
import 'state_applylist.dart';
import 'state_myproject.dart';
// provider
import 'package:provider/provider.dart';

boxItem(int index, List<Container> items) {
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
          Expanded(flex: 2, child: listItemButton())
        ],
      ));
}

boxItem_apply(int index, List<Container> items) {
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
          Expanded(flex: 2, child: listItemButton())
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

Widget listItemButton() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () {},
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
          onPressed: () {},
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
              onPressed: () => routerReader.navigateTo(routerWatcher.currentPage, '/state/myproject'),
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
