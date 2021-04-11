import 'package:flutter/material.dart';
// components
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
// pages
import 'package:iruri/pages/home/home.dart';
import 'package:iruri/pages/home/project_detail.dart';
import 'package:iruri/pages/personal/personal.dart';
import 'package:iruri/pages/post_article.dart';
import 'package:iruri/pages/state/state_projectlist.dart';
import 'package:iruri/pages/state/state_myproject.dart';
import 'package:iruri/pages/state/state_applylist.dart';

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

// page route
var page = [
  {'name': '게시글', 'page': HomePage()},
  {'name': '매칭현황', 'page': ProjectListPage()},
  {'name': '내정보', 'page': PersonalPage()},
  {'name': '내가 쓴 게시글', 'page': MyprojectPage()},
  {'name': '지원한 게시글', 'page': ApplyListPage()},
  {'name': '프로젝트 상세', 'page': ProjectDetailPage()},

];

class _RoutesState extends State<Routes> {
  // current page index
  var currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  changePageIndex() {
    setState(() {
      currentPageIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR : Top of application
        appBar: appBar(currentPageIndex),
        // body
        body: GestureDetector(
            // used in keyboard dismiss and so on
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              child: page[currentPageIndex]['page'],
            )),
        bottomNavigationBar: bottomNavigationBar());
  }
  /*
   *  Flutter 에서 제공해주는 BottomNavigationBar를 사용
   *  현재 각 label은 안보이게 설정하였음 - 2021.04.08 
   */
  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: [
        // 왼쪽부터 나열 됩니다.
        BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article_rounded),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.palette_outlined),
            activeIcon: Icon(Icons.palette_rounded),
            label: 'Match'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person),
            label: 'My')
      ],
      onTap: (index) {
        // page index 변경
        setState(() {
          currentPageIndex = index;
        });
      },
      // hide all labels
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // Icon settings
      selectedItemColor: themeLightOrange,
      // set current index of page for selectedItemColor
      currentIndex: currentPageIndex,
    );
  }
}

  /*
   *  Flutter 에서 제공해주는 AppBar를 사용 
   *    탭 이동마다 맨 위 제목이 바뀌게 설정 - 2021.04.09
   */
AppBar appBar(int currentPageIndex) {
  return AppBar(
    title: Text(page[currentPageIndex]['name'], style: appBarTitleTextStyle),
    backgroundColor: Colors.white,
    shadowColor: themeLightGrayOpacity20,
    elevation: 1.0, // less shadow
    // '+' button : post new article
    // 게시글 추가는 [홈]에서만 가능하게 하도록 삼항연산자로 구현
    actions: <Widget>[
      currentPageIndex == 0
          ? IconButton(
              icon:
                  Icon(Icons.add_circle_outline_rounded, color: themeGrayText),
              // navigation to article form page
              // TODO : 새로운 게시글 등록 화면 이동
              onPressed: () => print('add new article !'),
            )
          : SizedBox() // SizedBox() 는 아무것도 없는 것을 의미합니다.
    ],
  );
}
