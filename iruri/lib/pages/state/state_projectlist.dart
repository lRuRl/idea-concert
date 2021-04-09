import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  ScrollController scrollController = new ScrollController();
  ScrollController listScrollController = new ScrollController();

  @override
  void initState() {
    ListViewHorizontal();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width * 1.0,
          color: Color.fromRGBO(255, 255, 255, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.12,
                child: selectButton(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Color.fromRGBO(255, 255, 255, 1),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.32,
                child: myProject(),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.32,
                child: applyProject(),
              ),
            ],
          ),
        ));
  }
}

Widget myProject() {
  return Column(children: [
    Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText("내가 올린 프로젝트 "),
            Icon(Icons.chevron_right, size: 30),
          ],
        )),
    Expanded(flex: 4, child: myList()),
    Expanded(flex: 1, child: Text('')),
  ]);
}

List<Container> items;
ListViewHorizontal() {
  items = List<Container>.generate(5, (index) {
    return boxItem(index);
  });
}

boxItem(int index) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 220,
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
                          children: [
                            Text(
                              "#뎃생 ",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              "#채색 ",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              "#콘티",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
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

Widget myList() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (context, index) {
      return items[index];
    },
  );
}

Widget applyProject() {
  return Column(children: [
    Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText("내가 지원한 프로젝트 "),
            Icon(Icons.chevron_right, size: 30),
          ],
        )),
    Expanded(
      flex: 4,
      child: myList(),
    ),
    Expanded(flex: 1, child: Text('')),
  ]);
}

Widget boldText(String txt) {
  return Text(txt, style: TextStyle(fontWeight: FontWeight.w700));
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
            padding: EdgeInsets.all(3),
            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
            onPrimary: Colors.white,
            fixedSize: Size(140, 50),
          )),
      ElevatedButton(
          onPressed: () {},
          child: Text("완료된 프로젝트"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(3),
            primary: Colors.white,
            onPrimary: Color.fromRGBO(0x82, 0x82, 0x82, 1),
            fixedSize: Size(140, 50),
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
            padding: EdgeInsets.all(0),
            fixedSize: Size(90, 30),
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
            padding: EdgeInsets.all(0),
            fixedSize: Size(90, 30),
            primary: Color.fromRGBO(0x1B, 0x30, 0x59, 1),
            onPrimary: Colors.white,
          ))
    ],
  );
}
