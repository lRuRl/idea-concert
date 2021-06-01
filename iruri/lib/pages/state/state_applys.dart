import 'package:flutter/material.dart';
import 'package:iruri/pages/home/project_detail_components.dart';
import 'package:iruri/pages/state/state_utils.dart';
import 'package:iruri/components/typhography.dart';
// provider
import 'package:provider/provider.dart';
import 'package:iruri/provider.dart';

// UserAPI
import 'package:iruri/util/data_user.dart';

// article
import 'package:iruri/model/article.dart';

class StateApplys extends StatefulWidget {
  final Article article;
  StateApplys({this.article});
  @override
  _StateApplysState createState() => _StateApplysState();
}

class _StateApplysState extends State<StateApplys> {
  ScrollController scrollController = ScrollController();
  UserAPI userAPI = UserAPI();
  var fetchedData;

  @override
  void initState() {
    fetchedData = userAPI.findAll();
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
                        print(snapshot.data.length.toString());
                        return Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.98,
                          child: applicant_vertical(
                              context,
                              List<Container>.generate(snapshot.data.length,
                                  (index) {
                                return containerApplys(index, context,
                                    snapshot.data[index], widget.article);
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
