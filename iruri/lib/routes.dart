import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// components
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
// pages
import 'package:iruri/pages/home/home.dart';
import 'package:iruri/pages/home/post_article.dart';
import 'package:iruri/pages/home/project_detail.dart';
import 'package:iruri/pages/personal/personal.dart';
import 'package:iruri/pages/signup/signup.dart';
import 'package:iruri/pages/state/fill_contract.dart';
import 'package:iruri/pages/state/state_projectlist.dart';
import 'package:iruri/pages/state/state_myproject.dart';
import 'package:iruri/pages/state/state_applylist.dart';
import 'package:iruri/pages/state/state_myproject.dart';
import 'package:iruri/pages/state/state_applys.dart';
import 'package:iruri/pages/state/state_projectlist.dart';
import 'package:iruri/pages/state/state_detailpage.dart';

// provider
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';

// ignore: slash_for_doc_comments
/**
 *  Routes
 *  HOME : 매칭이 이루어지는 탭
 *  STATE : 매칭 현황을 볼 수 있는 탭
 *  PERSONAL : 개인 설정을 할 수 있는 탭
 * 
 *  page route를 위해서 StatefulWidget으로 구현
 */
class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  // current page index
  var currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  var page = {
    '/': HomePage(),
    '/state': ProjectListPage(),
    '/personal': PersonalPage(),
    '/state/myproject': MyprojectPage(),
    '/state/applylist': ApplyListPage(),
    '/home/projectdetail': ProjectDetailPage(),
    '/state/projectdetail': StateProjectDetailPage(),
    '/state/fillcontract': FillContractPage(),
    '/state/stateapplys': StateApplys(),
    '/state/stateapplys/personal': PersonalPage(),
  };

  @override
  Widget build(BuildContext context) {
    // provider
    final routerWatcher = context.watch<CustomRouter>();

    return Scaffold(
        // APP BAR : Top of application
        appBar: appBar(context),
        // body
        body: GestureDetector(
            // used in keyboard dismiss and so on
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              color: Colors.white, // background color added
              // child: page[currentPageIndex]['page'],
              // use Provier<CustomRouter>
              child: page[routerWatcher.currentPage],
            )),
        bottomNavigationBar: bottomNavigationBar(context));
  }

  /*
   *  Flutter 에서 제공해주는 AppBar를 사용 
   *    탭 이동마다 맨 위 제목이 바뀌게 설정 - 2021.04.09
   */
  AppBar appBar(BuildContext context) {
    // provider
    final routerWatcher = context.watch<CustomRouter>();
    final routerReader = context.read<CustomRouter>();

    return AppBar(
      // title: Text(page[currentPageIndex]['name'], style: appBarTitleTextStyle),
      centerTitle: true,
      title: Text(
        'IRURI',
        style: montSesrratTextStyle(textColor: displayText),
      ),
      backgroundColor: Colors.white,
      shadowColor: themeLightGrayOpacity20,
      elevation: 1.0, // less shadow
      // '+' button : post new article
      // 게시글 추가는 [홈]에서만 가능하게 하도록 삼항연산자로 구현
      actions: <Widget>[
        routerWatcher.index == 0
            ? IconButton(
                icon: Icon(FeatherIcons.plusCircle, color: primaryLine),
                // navigation to article form page
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => PostArticle())),
              )
            : SizedBox() // SizedBox() 는 아무것도 없는 것을 의미합니다.
      ],
      // 2중으로 들어간 경우에는 뒤로가기 만들어주기
      leading: routerWatcher.currentPage.split('/').length > 2
          ? IconButton(
              icon: Icon(Icons.keyboard_arrow_left_rounded, color: primaryLine),
              onPressed: () => routerReader.navigateTo(
                    routerWatcher.currentPage ==
                                '/state/stateapplys/personal' &&
                            routerWatcher.prevPage == '/state/stateapplys'
                        ? '/state'
                        : routerWatcher.currentPage,
                    routerWatcher.currentPage ==
                                '/state/stateapplys/personal' &&
                            routerWatcher.prevPage == '/state/stateapplys'
                        ? '/state/stateapplys'
                        : routerWatcher.prevPage,
                    data: routerWatcher.data,
                    article: routerWatcher.article,
                  ))
          : SizedBox(),
    );
  }

  /*
   *  Flutter 에서 제공해주는 BottomNavigationBar를 사용
   *  현재 각 label은 안보이게 설정하였음 - 2021.04.08 
   */
  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    // provider
    final routerReader = context.read<CustomRouter>();
    final routerWatcher = context.watch<CustomRouter>();

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: [
        // 왼쪽부터 나열 됩니다.
        BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.home,
              color: primaryLine,
            ),
            activeIcon: Icon(FeatherIcons.home),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.trello,
              color: primaryLine,
            ),
            activeIcon: Icon(FeatherIcons.trello),
            label: 'Match'),
        BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.user,
              color: primaryLine,
            ),
            activeIcon: Icon(FeatherIcons.user),
            label: 'My')
      ],
      // page index 변경
      onTap: (index) {
        // set index
        routerReader.setIndex(index);
        // set name, the tap has changed -> new page
        String path;
        switch (index) {
          case 0:
            path = '/';
            break;
          case 1:
            path = '/state';
            break;
          case 2:
            path = '/personal';
            break;
          default:
            break;
        }
        // save prev page and navigate to curr page
        routerReader.navigateTo(routerWatcher.currentPage, path);
      },
      // hide all labels
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // Icon settings
      selectedItemColor: themeLightOrange,
      // set current index of page for selectedItemColor
      // used Provider - 2021.04.12
      currentIndex: context.watch<CustomRouter>().index,
    );
  }
}
