import 'package:flutter/material.dart';
// State Utils
import 'package:iruri/pages/state/state_utils/state_component.dart';
// Model
import 'package:iruri/util/data_article.dart';

class PostProjectPage extends StatefulWidget {
  @override
  _PostProjectPageState createState() => _PostProjectPageState();
}

class _PostProjectPageState extends State<PostProjectPage> {
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
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: MediaQuery.of(context).size.height * 0.98,
                          child: myProject_vertical(
                              context,
                              List<Container>.generate(snapshot.data.length,
                                  (index) {
                                return boxItem(
                                    index, context, snapshot.data[index]);
                              })),
                        );
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
