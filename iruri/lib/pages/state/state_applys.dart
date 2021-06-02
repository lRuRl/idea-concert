import 'package:flutter/material.dart';
import 'package:iruri/pages/home/project_detail_components.dart';
import 'package:iruri/pages/state/state_utils.dart';
import 'package:iruri/components/typhography.dart';
// provider
import 'package:provider/provider.dart';
import 'package:iruri/provider.dart';

// UserAPI
import 'package:iruri/util/data_user.dart';
import 'package:iruri/model/user.dart';

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

  List<String> applicantUidList;
  @override
  void initState() {
    fetchedData = userAPI.findAll();
  }

  @override
  Widget build(BuildContext context) {
    final routerWatcher = context.watch<CustomRouter>();
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
                        List<User> userList = snapshot.data;
                        List<User> filterdList = [];
                        List<String> applicantUidList =
                            getUidList(routerWatcher.data);

                        if (userList?.isEmpty == false) {
                          for (int i = 0; i < userList.length; i++) {
                            bool isExist = false;
                            for (int j = 0; j < applicantUidList.length; j++) {
                              if (userList[i].uid == applicantUidList[j]) {
                                isExist = true;
                                filterdList.add(userList[i]);
                                break;
                              }
                            }
                          }
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.98,
                          child: applicant_vertical(
                              context,
                              List<Container>.generate(filterdList.length,
                                  (index) {
                                return containerApplys(index, context,
                                    filterdList[index], routerWatcher.data);
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
