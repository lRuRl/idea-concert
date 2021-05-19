import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/text_form_field.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/util/data_article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/*
 *  [ 홈 ] : 매칭피드
 *  구성요소 : 
 *    - 검색 바 -> [ 검색 칸, 검색 버튼 ]
 *    - 태그 바 -> [ 태그 텍스트, 태그 버튼을 누를 수 있는 둥근 칸 ]
 *    - 모집 중인 공고 -> [ 모집 중인 공고 텍스트, 설정된 태그, 공고 리스트 뷰 ]
 *  
 *  @params
 *    scrollController : scrollcontroller
 *    textEditingController : 검색 칸에 쓰일 controller, text 관련 작업이 수월
 *    tags[] : 현재 설정된 tag들을 담아둘 list
 *    fetchedList[] : 서버로 부터 받아올 모집중인 공고 list
 * 
 *  @Widgets
 *    searchContainer : 검색 바
 *    tagContainer    : 태그 바
 *    recruitContainer : 모집 중인 공고
 */
class _HomePageState extends State<HomePage> {
  // @params
  ScrollController scrollController; // ScrollController 로 스크롤 높이 등을 조절할 수 있습니다.
  TextEditingController textEditingController;
  // var tags;
  var fetchedData;
  ArticleAPI api = new ArticleAPI();

  @override
  void initState() {
    super.initState();
    // controller init
    scrollController = new ScrollController();
    textEditingController = new TextEditingController();
    // fetchedData added : 2021/05/18 @seunghwanly
    fetchedData = api.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SEARCH CONTAINER
            searchContainer(),
            // TAG CONTAINER
            tagContainer(),
            // RECRUIT CONTAINER
            FutureBuilder(
              future: fetchedData,
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: Image.asset('assets/loading.gif', width: 35, height: 35)
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('500 - server'));
                } else{
                  return recruitContainer(snapshot.data);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  // searchContainer
  Widget searchContainer() {
    // TODO: referesh list
    void _searchItem({value}) {
      print(value != null
          ? value + ' searched from user'
          : textEditingController.text + ' searched from user');
    }

    return Container(
      margin: marginCustom(hor: 20, ver: 15),
      child: Row(
        // Search Text Bar / Search Button
        children: <Widget>[
          // Search Text Bar
          Expanded(
            flex: 9,
            child: TextFormField(
              controller: textEditingController,
              onFieldSubmitted: (value) => _searchItem(value: value),
              onChanged: (value) {
                setState(() {
                  // get text saved
                  textEditingController.text = value;
                  // get cursor on the max length of text
                  textEditingController.selection = TextSelection.fromPosition(
                      TextPosition(offset: textEditingController.text.length));
                });
              },
              // decoration
              decoration: searchInputDecoration,
              cursorColor: themeLightOrange,
            ),
          ),
          // Search Button
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.search_rounded),
              iconSize: 25,
              onPressed: () => _searchItem(),
            ),
          )
        ],
      ),
    );
  }

  /*
   *  TODO: @sooo19 태그 컨테이너 만들기
   *  - 위에는 '태그' 글씨가 들어가야합니다. fontSize : 18, fontWeight : bold
   *  - 둥근 사각형으로 구성이 되어있습니다. 아이폰X 기준 가로 : 345px, 세로 : 80px, 선 색깔 : #F2F2F2, borderRadius : 20
   *  - 같은 아이템으로 6개가 나열되어 있는데 이는 두가지 방법을 사용할 수 있습니다.
   *    1) 하나씩 선언해주기
   *    2) ListView 사용하기
   *  - 1번 같은 경우에는 2번보다는 코드가 조금 더 길 수 있지만 그만큼 더 직관적입니다. 그리고 2번과는 다르게 어떤 배열이나 Map<String, dynamic> 같은 객체를 사용해서 구현을 하지 않아도 됩니다.
   *  - 2번 같은 경우에는 ListView.builder( ) 같은 것을 사용해서 몇개의 변수와 함께 간략한 코드로 구현할 수 있습니다.
   *  >> 1번을 먼저 시도 해보시고, 2번을 시도해보세요 수림님.
   *    1번을 구현하시면 기본적인 레이아웃을 구현할 때 Row, Column에 대해서 이해되실거에요.
   *    그리고 mainAxisAlignment와 crossAxisAlignment를 이용해서 children [ ] 안에 있는 자식들을 정렬해보는 것도 도움이 될 겁니다.
   *    ListView를 사용하실 때는 전반적인 레이아웃에 대한 이해가 필요해서 조금 익숙해지시면 시도해보시는 걸 추천 드립니다. :)
   *  - 공통사항: 버튼을 눌렀을 때, setState(() { }); 를 통해서 현재 _HomePageState 안에 있는 tags[] 내용 값을 변경해주어야합니다.
   * 
   *  그럼 화이팅 !
   */

  // 수림 추가
  Widget tagContainer() {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Text('태그',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))), //태그 글씨
        Container(
          margin: EdgeInsets.only(bottom: 3, left: 5, right: 5, top: 2),
          height: 80,
          width: 345,
          decoration: BoxDecoration(
              // '태그' 회색 테투리 박스
              color: Color.fromRGBO(255, 255, 255, 1),
              border: Border.all(
                  width: 1, color: Color.fromRGBO(196, 196, 196, 0.13)),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            //버튼 6개
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, //6개의 버튼이 같은 간격을 가지도록 정렬
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13), //회색 네모 박스
                        borderRadius: BorderRadius.circular(12))),
                Container(
                    child: Text('# 글', style: TextStyle(fontSize: 10))) //글씨(#글)
              ]),
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.circular(12))),
                Container(child: Text('# 뎃셍', style: TextStyle(fontSize: 10)))
              ]),
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.circular(12))),
                Container(child: Text('# 그림', style: TextStyle(fontSize: 10)))
              ]),
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.circular(12))),
                Container(child: Text('# 캐릭터', style: TextStyle(fontSize: 10)))
              ]),
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.circular(12))),
                Container(child: Text('# 콘티', style: TextStyle(fontSize: 10)))
              ]),
              Column(children: <Widget>[
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 0.13),
                        borderRadius: BorderRadius.circular(12))),
                Container(child: Text('# 채색', style: TextStyle(fontSize: 10)))
              ]),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget recruitContainer(List<Article> data) {  
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: SizedBox(height: 20),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                padding: paddingH20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("모집중인공고", style: articleTitleTextStyle),
                    Text("TAGS")
                  ],
                ))),
        Align(
            alignment: Alignment.center,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true, // 자동으로 길이를 조정해주는 느낌
              itemCount: data.length, // 리스트 뷰안에 있는 자식 객체 수
              itemBuilder: (context, index) {
                return HomeArticle(
                  data: data[index],
                );
              },
            ))
      ],
    );
  }
}
