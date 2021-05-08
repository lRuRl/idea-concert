import 'dart:js';

import 'package:flutter/material.dart';
import 'state_utils.dart';
import 'package:iruri/routes.dart';

class ApplyListPage extends StatefulWidget {
  @override
  _ApplyListPageState createState() => _ApplyListPageState();
}

List<Container> applyListitems;
ListViewVertical(BuildContext context) {
  applyListitems = List<Container>.generate(5, (index) {
    return boxItem_apply(index, applyListitems, context);
  });
}

class _ApplyListPageState extends State<ApplyListPage> {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR : Top of application
        //appBar: appBar(4),
        // body
        body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 1.0,
              width: MediaQuery.of(context).size.width * 1.0,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     top: BorderSide(
                    //         width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                    //   ),
                    //   color: Color.fromRGBO(255, 255, 255, 1),
                    // ),
                    // padding: EdgeInsets.symmetric(horizontal: 15),

                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: applyProject_vertical(
                        context,
                        List<Container>.generate(5, (index) {
                          return boxItem_apply(index, applyListitems, context);
                        })),
                  ),
                ],
              ),
            )));
  }
}
