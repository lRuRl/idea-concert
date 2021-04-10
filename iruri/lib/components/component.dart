import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';

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
            child: ImageWrapper(imagePath: data.imagePath),
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
                                child: Text(data.title,
                                    style: articleTitleTextStyle)),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_right_rounded),
                                iconSize: 20,
                                onPressed: () => print('look'),
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
                                  childAspectRatio: 4/2,
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 5),
                          itemCount: data.tags.length,
                          itemBuilder: (context, index) => TagWrapper(
                                onPressed: () => print('tag pressed'),
                                tag: data.tags[index],
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
                          Text(data.writer, style: articleWriterTextStyle),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Text>[
                                Text('마감일 ', style: articleWriterTextStyle),
                                Text(data.dueDate,
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
    '뎃셍': tagDessin,
  };

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // primary: colorMapper[tag],
          backgroundColor: colorMapper[tag],
          alignment: Alignment.center,
          elevation: 0.0, // no shadow
          padding: paddingH6V4
          ),
      child: Text('# ' + tag, style: articleTagTextStyle),
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
    return ClipRect(
      child: Container(
        width: size.width * 0.27,
        height: size.width * 0.27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: lightWhite),
        child: Align(
          alignment: Alignment.center,
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Image.network(
            widget.imagePath,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error_outline_rounded, size: 24),
          ),
        ),
      ),
    );
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
 * 
 *  그럼 화이팅 !
 */
