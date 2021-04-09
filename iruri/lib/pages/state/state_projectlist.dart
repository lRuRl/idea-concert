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
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Color.fromRGBO(255, 255, 255, 1),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.32,
                child: applyProject(),
              ),
            ],
          ),
        ));
  }
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
            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
            onPrimary: Colors.white,
          )),
      ElevatedButton(
          onPressed: () {},
          child: Text("완료된 프로젝트"),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
          ))
    ],
  );
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
  items = List<Container>.generate(100, (index) {
    return boxItem(index);
  });
}

boxItem(int index) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
        color: (index % 3 == 0)
            ? Colors.red
            : (index % 3 == 1)
                ? Colors.blue
                : Colors.orange),
    alignment: Alignment(0, 0),
    child: Text(
      "Item $index",
      style: TextStyle(color: Colors.white),
    ),
  );
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
