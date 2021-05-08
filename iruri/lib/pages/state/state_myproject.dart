import 'package:flutter/material.dart';
import 'state_utils.dart';
import 'package:iruri/routes.dart';

class MyprojectPage extends StatefulWidget {
  @override
  _MyprojectPageState createState() => _MyprojectPageState();
}

List<Container> myProjectListItems;
// ListViewVertical() {
//   myProjectListItems = List<Container>.generate(5, (index) {
//     return boxItem(index, myProjectListItems);
//   });
// }

class _MyprojectPageState extends State<MyprojectPage> {
  ScrollController scrollController = new ScrollController();

  // @override
  // void initState() {
  //   ListViewVertical();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR : Top of application
        // appBar: appBar(3),

        // body
        body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 1,
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

                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.98,
                    child: myProject_vertical(
                        context,
                        List<Container>.generate(5, (index) {
                          return boxItem(index, myProjectListItems, context);
                        })),
                  ),
                ],
              ),
            )));
  }
}
