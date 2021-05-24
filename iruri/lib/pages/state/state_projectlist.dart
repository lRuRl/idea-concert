import 'package:flutter/material.dart';
import 'state_utils.dart';
import 'package:iruri/util/data_article.dart';
import 'package:iruri/model/article.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  var fetchedData;
  ArticleAPI api = new ArticleAPI();

  ScrollController scrollController = new ScrollController();
  ScrollController listScrollController = new ScrollController();

  @override
  void initState() {
    fetchedData = api.findAll();
  }

  // @override
  // void initState() {
  //   ListViewHorizontal();
  //   ListViewHorizontal_apply();
  // }

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
                height: MediaQuery.of(context).size.height * 0.35,
                child: FutureBuilder(
                  future: fetchedData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Image.asset('assets/loading.gif',
                              width: 35, height: 35));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('500 - server'));
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.98,
                        child: myProject(
                            context,
                            List<Container>.generate(snapshot.data.length,
                                (index) {
                              return boxItem(
                                  index, items, context, snapshot.data[index]);
                            })),
                      );
                    }
                  },
                ),

                // myProject(
                // context,
                // List<Container>.generate(5, (index) {
                //   return boxItem(index, items, context);
                // })),
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
                height: MediaQuery.of(context).size.height * 0.35,
                child: FutureBuilder(
                  future: fetchedData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Image.asset('assets/loading.gif',
                              width: 35, height: 35));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('500 - server'));
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.98,
                        child: applyProject(
                            context,
                            List<Container>.generate(snapshot.data.length,
                                (index) {
                              return boxItem_apply(
                                  index,
                                  items,
                                  context,
                                  snapshot
                                      .data[snapshot.data.length - 1 - index]);
                            })),
                      );
                    }
                  },
                ),

                // applyProject(
                //   context,
                //   List<Container>.generate(5, (index) {
                //     return boxItem_apply(index, items, context);
                //   })),
              ),
            ],
          ),
        ));
  }
}

List<Container> items;
// ListViewHorizontal() {
//   items = List<Container>.generate(5, (index) {
//     return boxItem(index, items);
//   });
// }

// List<Container> items_apply;
// ListViewHorizontal_apply() {
//   items_apply = List<Container>.generate(5, (index) {
//     return boxItem_apply(index, items);
//   });
// }
