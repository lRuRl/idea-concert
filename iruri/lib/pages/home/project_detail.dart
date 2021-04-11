import 'package:flutter/material.dart';
import 'package:iruri/routes.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:flutter/services.dart';

class ProjectDetailPage extends StatefulWidget {
  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR : Top of application
        appBar: appBar(5),
        // body
        body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("썸네일"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("공고 상세보기"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 5,
                            color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Text("프로젝트 일정"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 5,
                            color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Text("프로젝트 상세 내용"),
                  )
                ],
              ),
            )));
  }
}
