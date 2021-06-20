import 'package:flutter/material.dart';
import 'state_utils.dart';
import 'package:iruri/routes.dart';
import 'package:iruri/util/api_article.dart';

class ApplyListPage extends StatefulWidget {
  @override
  _ApplyListPageState createState() => _ApplyListPageState();
}

List<Container> applyListitems;
// ListViewVertical(BuildContext context) {
//   applyListitems = List<Container>.generate(5, (index) {
//     return boxItem_apply(index, applyListitems, context,);
//   });
// }

class _ApplyListPageState extends State<ApplyListPage> {
  ScrollController scrollController = new ScrollController();
  var fetchedData;
  ArticleAPI api = new ArticleAPI();

  @override
  void initState() {
    super.initState();
    fetchedData = api.findAll();
  }

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
                  FutureBuilder(
                    future: fetchedData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: Center(
                                child: Image.asset('assets/loading.gif',
                                    width: 35, height: 35)));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('500 - server'));
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.78,
                          height: MediaQuery.of(context).size.height * 0.98,
                          child: applyProject_vertical(
                              context,
                              List<Container>.generate(snapshot.data.length,
                                  (index) {
                                return boxItem_apply(index, applyListitems,
                                    context, snapshot.data[index]);
                              })),
                        );
                      }
                    },
                  ),

                  // Container(
                  //   width: MediaQuery.of(context).size.width * 1,
                  //   height: MediaQuery.of(context).size.height * 1.0,
                  //   child: applyProject_vertical(
                  //       context,
                  //       List<Container>.generate(5, (index) {
                  //         return boxItem_apply(index, applyListitems, context);
                  //       })),
                  // ),
                ],
              ),
            )));
  }
}
