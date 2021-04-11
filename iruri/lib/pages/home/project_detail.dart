import 'package:flutter/material.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/project_utils.dart';
import 'package:iruri/routes.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:flutter/services.dart';

class ProjectDetailPage extends StatefulWidget {
  Article data;
  ProjectDetailPage({Key key, @required this.data}): super(key: key);
  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState(data);
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ScrollController scrollController = new ScrollController();
  
  final Article data;
  _ProjectDetailPageState(this.data);

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
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: thumbnail(context, data),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: noticeDetail(context, data),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 5,
                            color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: projectCalendar(context, data),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 5,
                            color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: projectDetailContent(context, data),
                  ),
                ],
              ),
            )));
  }
}
