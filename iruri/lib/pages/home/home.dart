import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/text_form_field.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'package:iruri/util/data_article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage({Key key, this.title, this.title2}) : super(key: key);
  final String title, title2;
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

  // data
  // save data
  Map<String, Map<String, bool>> applicantType = {
    '메인글': {'write_main': false},
    '글콘티': {'write_conti': false},
    '메인그림': {'draw_main': false},
    '그림콘티': {'draw_conti': false},
    '뎃셍': {'draw_dessin': false},
    '선화': {'draw_line': false},
    '캐릭터': {'draw_char': false},
    '채색': {'draw_color': false},
    '후보정': {'draw_after': false}
  };

  Map<String, Map<String, bool>> genreType = {
    '스릴러': {'thriller': false},
    '드라마': {'drama': false},
    '판타지': {'fantasy': false},
    '액션': {'action': false},
    '무협': {'muhyup': false},
    '로맨스': {'romance': false},
    '학원': {'teen': false},
    '코믹': {'comic': false},
    '일상': {'daily': false},
    '스포츠': {'sports': false},
    '시대극': {'costume': false},
    '공포': {'horror': false},
    'SF': {'sf': false}
  };
  void applicantTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      applicantType = map;
    });
  }

  void genreTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      genreType = map;
    });
  }

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
            SizedBox(height: 20),
            // RECRUIT CONTAINER
            FutureBuilder(
              future: fetchedData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      height: 600,
                      child: Center(
                          child: Image.asset('assets/loading.gif',
                              width: 35, height: 35)));
                } else if (snapshot.hasError) {
                  return Center(child: Text('500 - server'));
                } else {
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
              icon: Icon(FeatherIcons.search),
              iconSize: 25,
              onPressed: () => _searchItem(),
            ),
          )
        ],
      ),
    );
  }

  Container tagBottomSheet(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: paddingH20V20,
        child: MultiChoiceChip(
          choiceChipType: 0,
          typeMap: applicantType,
          onSelectionChanged: applicantTypeChanged,
        ),
      );

  Container genreBottomSheet(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: paddingH20V20,
        child: MultiChoiceChip(
          choiceChipType: 1,
          typeMap: genreType,
          onSelectionChanged: genreTypeChanged,
        ),
      );

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
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () => showModalBottomSheet(
                              context: context, builder: tagBottomSheet),
                          child: Text('태그', style: bodyTextStyle),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: lightWhite, width: 2.0))),
                        ),
                        SizedBox(width: 10.0),
                        TextButton(
                            onPressed: () => showModalBottomSheet(
                                context: context, builder: genreBottomSheet),
                            child: Text('장르', style: bodyTextStyle),
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: lightWhite, width: 2.0)))),
                      ],
                    )
                  ],
                ))),
        Align(
            alignment: Alignment.center,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true, // 자동으로 길이를 조정해주는 느낌
              itemCount: data.length, // 리스트 뷰안에 있는 자식 객체 수
              itemBuilder: (context, index) {
                /// TODO [ filtering ] for states that are set
                return HomeArticle(
                  data: data[index],
                );
              },
            ))
      ],
    );
  }
}
