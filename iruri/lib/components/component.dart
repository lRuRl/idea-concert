import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/project_detail.dart';
import 'package:iruri/components/input_decoration.dart';
// provider
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iruri/provider.dart';
import 'package:image_picker/image_picker.dart';

// light gray 색 구분선
const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);

class HomeArticle extends StatelessWidget {
  // data input
  final Article data;
  const HomeArticle({this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // provider
    final routerReader = context.read<CustomRouter>();
    final routerWatcher = context.watch<CustomRouter>();

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
                                child: Text(data.detail.content.title,
                                    style: articleTitleTextStyle)),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_right_rounded),
                                iconSize: 20,
                                onPressed: () => routerReader.navigateTo(
                                    routerWatcher.currentPage,
                                    '/home/projectdetail',
                                    data: data),
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
                                    'D-DAY ' +
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////                              프로필 정보 : 석운                             /////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ProfileInfo {
  String nickname;
  String phone;
  String email;
  ProfileInfo({this.nickname, this.phone, this.email});
}
ProfileInfo testInput = ProfileInfo(
      nickname: "parkjang",
      phone: "010-XXXX-XXXX",
      email: "parkjang@naver.com"
);

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var index;
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;
  String imagePath;
  TextEditingController nameEditor_ = new TextEditingController(text: testInput.nickname);
  TextEditingController phoneEditor_ = new TextEditingController(text: testInput.phone);
  TextEditingController emailEditor_ = new TextEditingController(text: testInput.email);


  @override
  void initState() {
    super.initState();
    index = false;
    _image = null;
    //need to be personal info which should be already stored in DB
    //내 temporary 이미지 path
    imagePath = "/data/user/0/com.example.iruri/cache/image_picker4896229670943898999.jpg";
  }

  changeIndex() {
    setState(() {
      index = !index;
      testInput.nickname = nameEditor_.text;
      testInput.phone = phoneEditor_.text;
      testInput.email = emailEditor_.text;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var profileContent, icon, changeButton, imageChangeButton;

    if (index == false) {
      profileContent = showProfileContent(width, height, testInput);
      icon = changeIcon();
      changeButton = Container();
      imageChangeButton = Container();
    } else {
      profileContent = changeProfileContent(nameEditor_, phoneEditor_, emailEditor_, width, height, testInput);
      icon = Container();
      changeButton = confirmChangeButton();
      imageChangeButton = confirmImageChangeButton();
    }

    return Container(
      child: Column(
      children: <Widget>[
        //프로필 상단 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("프로필 정보",
                style: TextStyle(fontWeight: FontWeight.w700),
                textAlign: TextAlign.left),
            icon,
          ],
        ),
        //프로필 하단 부분
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
              //프로필사진 컨테이너
              width: width * 0.3,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: themeLightGrayOpacity20,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.13,
                    //width: width * 10,
                    //padding: EdgeInsets.all(2),
                    child: //ImageWrapper(imagePath: imagePath),
                     ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(imagePath))
                    ),
                  ),
                  imageChangeButton
                ],
              ),
            ),
          Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
              children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 3, 0, 10),
              width: width * 0.15,
              alignment: Alignment.topLeft,
              child: Text(
                "닉네임",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 3, 0, 40),
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
          profileContent,
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: changeButton,
          )
        ])
      ],
    ));
  }

  //그림 수정 버튼
  Container confirmImageChangeButton() {
    return Container(
        alignment: Alignment.center,
        width: 40,
        height: 20,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: RaisedButton(
          padding: EdgeInsets.all(3),
          color: themeDeepBlue,
          onPressed: _getImage,
          child:
              Text("수정", style: TextStyle(color: Colors.white, fontSize: 10)),
        ));
  }
  
  Future _getImage() async{
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState((){
      _image = image;
    });
    if(image != null){
      setState((){
      imagePath = image.path;
    });
    print("path >>>> " + imagePath);
    }
  }


  //수정 화면에서 "수정하기" 버튼 => 누르면 원래 화면으로 돌아감 => 내용 수정은 차후로
  Container confirmChangeButton() {
    return Container(
        alignment: Alignment.center,
        width: 80,
        height: 30,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: RaisedButton(
          padding: EdgeInsets.all(3),
          color: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
          onPressed: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('수정이 완료되었습니다')),
                  content: Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          changeIndex();
                        },
                        child: Text("확인",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          primary: themeDeepBlue,
                          onPrimary: Colors.white,
                        )
                      )
                    ),
                  )
                );
              }),
          child: Text("저장하기", style: TextStyle(color: Colors.white)),
        ));
  }

  //초기 프로필 정보 화면에서 연필모양 아이콘 => 누르면 수정하는 화면으로 바뀜
  IconButton changeIcon() {
    return IconButton(
      icon: Icon(Icons.create_outlined),
      iconSize: 20,
      onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text('수정하시겠습니까')),
              content: 
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: 
                          ElevatedButton(
                          onPressed: () { Navigator.pop(context); },
                          style: ElevatedButton.styleFrom(
                            primary: themeDeepBlue,
                          ),
                          child: Text("취소", 
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )),
                          ),
                        )
                      ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: 
                        ElevatedButton(
                          onPressed: () { changeIndex(); },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                          ),
                          child: Text("확인",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )),
                          )
                        )
                      ),
                    ],
                  )
            );
          }),
    );
  }

  //프로필 정보 화면 초기상태
  Column showProfileContent(final width, final height, ProfileInfo testInput) {
    return Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: Text(
          testInput.nickname,
          style: TextStyle(fontSize: 11),
        ),
      ),
      Position(),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: Text(
          testInput.phone,
          style: TextStyle(fontSize: 11),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: Text(
          testInput.email,
          style: TextStyle(fontSize: 9),
        ),
      ),
    ]);
  }

  //연필 아이콘 누르면 수정하는 화면으로 바뀜
  Column changeProfileContent(
      TextEditingController nameEditor_, 
      TextEditingController phoneEditor_, 
      TextEditingController emailEditor_, 
      final width, 
      final height, 
      ProfileInfo testInput
    ) {
    return Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
        alignment: Alignment.topLeft,
        width: width * 0.45,
        height: height * 0.025,
        child: TextFormField(
          enabled: true,
          maxLines: 1,
          inputFormatters: [new LengthLimitingTextInputFormatter(20)],
          controller: nameEditor_,
          style: TextStyle(color: themeGrayText, fontSize: 10),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            fillColor: themeLightGrayOpacity20,
            filled: true,
            //labelStyle: TextStyle(color: themeGrayText, fontSize: 3),
            //labelText: testInput.nickname,
          ),
        ),
      ),
      Position_Small(),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
        alignment: Alignment.topLeft,
        width: width * 0.45,
        height: height * 0.025,
        child: TextFormField(
          enabled: true,
          maxLines: 1,
          inputFormatters: [new LengthLimitingTextInputFormatter(20)],
          controller: phoneEditor_,
          style: TextStyle(color: themeGrayText, fontSize: 10),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            fillColor: themeLightGrayOpacity20,
            filled: true,
            //labelStyle: TextStyle(color: themeGrayText, fontSize: 3),
            //labelText: testInput.phone,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
        alignment: Alignment.topLeft,
        width: width * 0.45,
        height: height * 0.025,
        child: TextFormField(
          enabled: true,
          maxLines: 1,
          inputFormatters: [new LengthLimitingTextInputFormatter(25)],
          controller: emailEditor_,
          style: TextStyle(color: themeGrayText, fontSize: 8),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: themeLightGrayOpacity20, width: 1),
                borderRadius: BorderRadius.circular(5)),
            fillColor: themeLightGrayOpacity20,
            filled: true,
            //labelStyle: TextStyle(color: themeGrayText, fontSize: 6),
            //labelText: testInput.email,
          ),
        ),
      ),
    ]);
  }
}

//포지션 태그 나타내는 클래스
class Position extends StatelessWidget {
  final List<String> data = ["채색", "콘티", "색칠", "캐릭터"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) {
      bottomMargin = 10;
    } else {
      bottomMargin = 35;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        alignment: Alignment.topCenter,
        width: size.width * 0.45,
        // decoration: BoxDecoration(
        //   border: Border.all( 
        //     width: 1,
        //     color: themeLightGrayOpacity20, 
        //   ),
        //   borderRadius: BorderRadius.circular(10),
        //   color: Colors.white,
        // ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
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
 final List<String> data = ["채색", "콘티", "색칠", "캐릭터"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) {
      bottomMargin = 3;
    } else {
      bottomMargin = 3;
    }
    return 
    Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        alignment: Alignment.topCenter,
        width: size.width * 0.45,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all( 
            width: 1,
            color: themeLightGrayOpacity20, 
          ),
          color: themeLightGrayOpacity20,
        ),
    child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
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
                              onPressed: () => print("tag pressed"),//_showDialog(context),
                              tag: data[index],
                            ))),
              )
            ]))
    );
  }
}

/*
void _showDialog(context) { 
    showDialog(
      context: context,
      barrierDismissible: false,  
      builder: (BuildContext context) { 
        return AlertDialog(
          title: Text("태그 선택"),
          content: Text("최대 6개 골라주세요"),
          actions: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('채색'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('콘티'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('캐릭터'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('그림'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('글'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('뎃셍'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('기타'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('기타'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('기타'),
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text('기타'),
                        ],
                      ),
                    ],
                  ),
                  FlatButton(
                    child: new Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ), 
                ],
              ),
            )
          ],
        );
      },
    );
  }
 */


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////                              프로필 정보 : 석운                             /////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ApprovalState extends StatelessWidget {
  int stateIndex = 0;
  ApprovalState({this.stateIndex});
  final List<String> data = ["승인대기", "승인수락", "승인거절"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // alignment: Alignment.topCenter,
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
