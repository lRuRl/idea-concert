import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/project_detail.dart';

// light gray 색 구분선
const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);

class HomeArticle extends StatelessWidget {
  // data input
  final Article data;
  const HomeArticle({this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightWhite),
      ),
      margin: marginH20V10,
      padding: paddingH20V20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        // Thumbnail | CONTENTS
        children: <Widget>[
          /**
           *  check image path
           *  1) not null, show image
           *  2) not null, but image not found
           *  3) null, default image
           */
          Expanded(
            flex: 2,
            child: ImageWrapper(imagePath: data.detail.content.imagePath),
          ),
          SizedBox(width: 20),
          // CONTENTS
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // title and iconbutton - spacebetween
                Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                // title
                                flex: 9,
                                child: Text(data.detail.content.introduction,
                                    style: articleTitleTextStyle)),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_right_rounded),
                                iconSize: 20,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProjectDetailPage(data: data),
                                      ));
                                },
                              ),
                            )
                          ],
                        ))),
                // tags -start
                Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 4 / 2,
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 5),
                          itemCount: data.detail.content.tags.length,
                          itemBuilder: (context, index) => TagWrapper(
                                onPressed: () => print('tag pressed'),
                                tag: data.detail.content.tags[index],
                              ))),
                ),
                // writer - start
                Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(data.detail.writer,
                              style: articleWriterTextStyle),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Text>[
                                Text('마감일 ', style: articleWriterTextStyle),
                                Text(
                                    'D' +
                                        DateTime.now()
                                            .difference(data.detail.dueDate)
                                            .inDays
                                            .toString(),
                                    style: articleDuedateTextStyle)
                              ])
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/**
 *  onPressed => required
 *  tag => only String !!!
 */
// ignore: must_be_immutable
class TagWrapper extends StatelessWidget {
  final onPressed;
  final String tag;

  TagWrapper({this.onPressed, this.tag});

  // tag color mapper
  Map<String, Color> colorMapper = {
    '글': tagWrite,
    '채색': tagPaint,
    '콘티': tagConti,
    '캐릭터': tagCharacter,
    '그림': tagDraw,
    '데생': tagDessin,
    '승인대기': tagApproval_WAIT,
    '승인수락': tagApproval_YES,
    '승인거절': tagApproval_NO,
  };

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // primary: colorMapper[tag],
          backgroundColor: colorMapper[tag],
          alignment: Alignment.center,
          elevation: 0.0, // no shadow
          padding: paddingH6V4),
      child: tag.substring(0, 1) == '승'
          ? Text(tag, style: articleTagTextStyle)
          : Text('# ' + tag, style: articleTagTextStyle),
    );
  }
}

// get image from network
class ImageWrapper extends StatefulWidget {
  final String imagePath;
  ImageWrapper({this.imagePath});
  @override
  _ImageWrapperState createState() => _ImageWrapperState();
}

class _ImageWrapperState extends State<ImageWrapper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Align(
          alignment: Alignment.center,
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: Image.network(
            widget.imagePath,
            width: size.width * 0.27,
            height: size.width * 0.27,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) => Icon(
                Icons.error_outline_rounded,
                size: 24,
                color: themeGrayText),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
        //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //left, top, right, bottom
        child: Column(
      children: <Widget>[
        //프로필 상단 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("프로필 정보",
                style: TextStyle(fontWeight: FontWeight.w700),
                textAlign: TextAlign.left),
            IconButton(
              icon: Icon(Icons.create_outlined),
              iconSize: 20,
              onPressed: () => print("look"),
            ),
          ],
        ),
        //프로필 하단 부분
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
              //프로필사진 컨테이너
              //height: height * 0.25,
              width: width * 0.3,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: themeLightGrayOpacity20,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('Icon-192.png')),
          Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
              children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: width * 0.15,
              alignment: Alignment.topLeft,
              child: Text(
                "닉네임",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 50),
              width: width * 0.15,
              alignment: Alignment.topLeft,
              child: Text(
                "포지션",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: width * 0.15,
              alignment: Alignment.topLeft,
              child: Text(
                "연락처",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: width * 0.15,
              alignment: Alignment.topLeft,
              child: Text(
                "이메일",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ]),
          Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
              children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.topCenter,
              child: Text(
                "parkjang",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Position(),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.topCenter,
              child: Text(
                "010-XXXX-XXXX",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.topCenter,
              child: Text(
                "parkjang@naver.com",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ]),
        ]),
      ],
    ));
  }
}

class Position extends StatelessWidget {
  final List<String> data = ["채색", "콘티", "캐릭터"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) {
      bottomMargin = 15;
    } else {
      bottomMargin = 40;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
        alignment: Alignment.topCenter,
        width: size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: lightWhite),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 5,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 1.5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                        itemCount: data.length,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => print('tag pressed'),
                              tag: data[index],
                            ))),
              )
            ]));
  }
}

class Position_Small extends StatelessWidget {
  final List<String> data = ["채색", "콘티", "캐릭터"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) {
      bottomMargin = 2;
    } else {
      bottomMargin = 5;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.topCenter,
        width: size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: lightWhite),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 5,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3.5 / 1.5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                        itemCount: data.length,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => print('tag pressed'),
                              tag: data[index],
                            ))),
              )
            ]));
  }
}

class ApprovalState extends StatelessWidget {
  int stateIndex = 0;
  ApprovalState({this.stateIndex});
  final List<String> data = ["승인대기", "승인수락", "승인거절"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.topCenter,
        width: size.width * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: lightWhite),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 5,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 1.5,
                            crossAxisCount: 1,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
                        itemCount: 1,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => print('tag pressed'),
                              tag: data[this.stateIndex],
                            ))),
              )
            ]));
  }
}

/**
 *  TODO : @jswboseok 프로필정보만들기
 *  1. 프로필 정보는 StatefulWidget으로 만들 것
 *  2. 나중에는 사용자의 정보를 받아와야 하기 때문에 현재 석운장이 만드는 컴포넌트를 FutureBuilder 안에 넣을 예정
 *  3. 석운장은 레이아웃 부터 잡고 시작하고 있음 됨
 *  4. 'stf' 를 입력하면 StatefulWidget 형태를 자동으로 생성해줌
 *  vscode 확장 프로그램 : Awesome Flutter Snippets
 *  ID: nash.awesome-flutter-snippets
 *  설명: Awesome Flutter Snippets is a collection snippets and shortcuts for commonly used Flutter functions and classes
 *  버전: 2.0.4
 *  게시자: Neevash Ramdial
 *  VS Marketplace 링크: https://marketplace.visualstudio.com/items?itemName=Nash.awesome-flutter-snippets
 * ∏
 *  그럼 화이팅 !
 */
