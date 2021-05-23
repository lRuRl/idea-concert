import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'package:iruri/pages/state/state_utils.dart';
import 'package:iruri/model/profile_info.dart';
// provider
import 'package:provider/provider.dart';
import 'package:iruri/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

    return InkWell(
        onTap: () => routerReader.navigateTo(
            routerWatcher.currentPage, '/home/projectdetail',
            data: data),
        child: Container(
          width: size.width * 0.9,
          height: size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // 8px
            border: Border.all(color: lightWhite, width: 3.0),
          ),
          margin: marginH20V10,
          padding: paddingH10V10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Thumbnail | CONTENTS
            children: <Widget>[
              Expanded(
                flex: 4,
                child: data.imagePath != null
                    ? ImageWrapper(image: data.image)
                    : Image.asset('assets/default.png'),
              ),
              SizedBox(width: 20),
              // CONTENTS
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // title and iconbutton - spacebetween
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    // title
                                    flex: 9,
                                    child: Text(data.detail.content.title,
                                        style: articleTitleTextStyle)),
                                Expanded(
                                    flex: 1,
                                    child: Icon(FeatherIcons.chevronRight))
                              ],
                            ))),
                    // tags -start
                    Expanded(
                      flex: 2,
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
                                    tag: data.detail.content.tags[index],
                                  ))),
                    ),
                    // genres - start
                    Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6),
                              itemCount: data.detail.content.genres.length,
                              itemBuilder: (context, index) {
                                if (index !=
                                    data.detail.content.genres.length - 1) {
                                  return Text(
                                      data.detail.content.genres[index] + ',',
                                      style: articleTagTextStyle);
                                } else
                                  return Text(data.detail.content.genres[index],
                                      style: articleTagTextStyle);
                              })),
                    ),
                    // writer - start
                    Expanded(
                      flex: 1,
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
                                        'D-' +
                                            DateTime.parse(data.detail.dueDate)
                                                .difference(DateTime.now())
                                                .inDays
                                                .toString(),
                                        style: articleDuedateTextStyle)
                                  ])
                            ],
                          )),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
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
    '선화': themeLightOrange,
    '콘티': tagConti,
    '캐릭터': tagCharacter,
    '그림': tagDraw,
    '데생': tagDessin,
    '후보정': themeBlue,
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

          padding: paddingH3V2),
      child: tag.substring(0, 1) == '승'
          ? Text(tag, style: articleTagTextStyle)
          : Text('# ' + tag, style: articleTagTextStyle),
    );
  }
}

// get image from network
class ImageWrapper extends StatefulWidget {
  final String image;
  ImageWrapper({this.image});
  @override
  _ImageWrapperState createState() => _ImageWrapperState();
}

class _ImageWrapperState extends State<ImageWrapper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        child: Image.memory(
          base64Decode(widget.image),
          height: size.width * 0.3,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.error_outline_rounded, size: 24, color: themeGrayText),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////                              프로필 정보 : 석운                             /////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<User> fetchUserInfo() async {
  final response = await http.get('http://172.30.1.45:3000/user');
  //final response = await http.get('http://localhost:3000/user');

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return User.fromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var index;
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;
  String imagePath;
  Future<User> user;
  String _id;
  TextEditingController nameEditor_;
  TextEditingController phoneEditor_;
  TextEditingController emailEditor_;

  @override
  void initState() {
    super.initState();
    index = false;
    _image = null;
    user = fetchUserInfo();
    //need to be personal info which should be already stored in DB
    //내 temporary 이미지 path
    //imagePath = "/data/user/0/com.example.iruri/cache/image_picker4896229670943898999.jpg";
    imagePath = "";
    _id = "60a303cfc232d343e0958685";
  }

  changeIndex() {
    setState(() {
      index = !index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var profileContent, icon, changeButton, imageChangeButton;

    if (index == false) {
      profileContent = showProfileContent(width, height);
      icon = changeIcon();
      changeButton = Container();
      imageChangeButton = Container();
    } else {
      profileContent = changeProfileContent(
          nameEditor_, phoneEditor_, emailEditor_, width, height);
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
                          child: Image.file(File(imagePath))),
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
  Widget confirmImageChangeButton() {
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

  Future _getImage() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
      print("path >>>> " + imagePath);
    }
  }

  //수정 화면에서 "수정하기" 버튼 => 누르면 원래 화면으로 돌아감 => 내용 수정은 차후로
  Widget confirmChangeButton() {
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                primary: themeDeepBlue,
                                onPrimary: Colors.white,
                              ))),
                    ));
              }),
          child: Text("저장하기", style: TextStyle(color: Colors.white)),
        ));
  }

  //초기 프로필 정보 화면에서 연필모양 아이콘 => 누르면 수정하는 화면으로 바뀜
  Widget changeIcon() {
    return IconButton(
      icon: Icon(Icons.create_outlined),
      iconSize: 20,
      onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Center(child: Text('수정하시겠습니까')),
                content: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: themeDeepBlue,
                        ),
                        child: Text("취소",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    )),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                changeIndex();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                              ),
                              child: Text("확인",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ))),
                  ],
                ));
          }),
    );
  }

  //프로필 정보 화면 초기상태
  Widget showProfileContent(final width, final height) {
    String nickname, phoneNumber, email;
    return Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child:  FutureBuilder<User>(
          future: this.user,
          builder: (context, snapshot) {
              for(int i = 0;i<snapshot.data.result.length;i++){
                if(snapshot.data.result[i].sId == this._id){
                  nickname = snapshot.data.result[i].profileInfo.nickname;
                  return Text(nickname,style: TextStyle(fontSize: 9),);
                }
              }
          }),
      ),
      FutureBuilder<User>(
          future: this.user,
          builder: (context, snapshot) {
              for(int i = 0;i<snapshot.data.result.length;i++){
                if(snapshot.data.result[i].sId == this._id){
                  List<String> roles = snapshot.data.result[i].roles;
                  return position(roles);
                }
              }
          }),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child:  FutureBuilder<User>(
          future: this.user,
          builder: (context, snapshot) {
              for(int i = 0;i<snapshot.data.result.length;i++){
                if(snapshot.data.result[i].sId == this._id){
                  phoneNumber = snapshot.data.result[i].profileInfo.phoneNumber;
                  return Text(phoneNumber,style: TextStyle(fontSize: 9),);
                }
              }
          }),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: FutureBuilder<User>(
          future: this.user,
          builder: (context, snapshot) {
              for(int i = 0;i<snapshot.data.result.length;i++){
                if(snapshot.data.result[i].sId == this._id){
                  email = snapshot.data.result[i].profileInfo.email;
                  return Text(email,style: TextStyle(fontSize: 9),);
                }
              }
          }),
      ),
    ]);
  }

  //연필 아이콘 누르면 수정하는 화면으로 바뀜
  Widget changeProfileContent(
      TextEditingController nameEditor_,
      TextEditingController phoneEditor_,
      TextEditingController emailEditor_,
      final width,
      final height,) {
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
      FutureBuilder<User>(
          future: this.user,
          builder: (context, snapshot) {
              for(int i = 0;i<snapshot.data.result.length;i++){
                if(snapshot.data.result[i].sId == this._id){
                  List<String> roles = snapshot.data.result[i].roles;
                  return changePosition(roles);
                }
              }
          }),
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

  Widget position(List<String> data){
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) bottomMargin = 10;
    else bottomMargin = 35;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      alignment: Alignment.topCenter,
      width: size.width * 0.45,
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
    
  Widget changePosition(List<String> data){
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) bottomMargin = 3;
    else bottomMargin = 3;

    return Container(
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
                    onPressed: () => _showDialog(context),
                    tag: data[index],
                ))),
              )
      ])));
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
    return Container(
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
                              onPressed: () =>
                                  print("tag pressed"), //_showDialog(context),
                              tag: data[index],
                            ))),
              )
            ])));
  }
}

class PositionChange extends StatefulWidget {
  @override
  _PositionChangeState createState() => _PositionChangeState();
}

class _PositionChangeState extends State<PositionChange> {
  Map<String, Map<String, dynamic>> _formTextField;

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

  String location;
  //  style
  var formTextStyle = notoSansTextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, textColor: greyText);
  
  @override
  void initState() {
    super.initState();
    _formTextField = new Map<String, Map<String, dynamic>>.from({
      "applicants": {"controller": null, "state": 0},
    }); // data
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: paddingH20V5,
      width: size.width * 0.9,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 3,
        color: _formTextField["applicants"]["state"] == 0
            ? Colors.transparent  : _formTextField["applicants"]["state"] ==  1
                ? onSuccess   : onError
          )),
        child: Column(
          children: <Widget>[
            MultiChoiceChip(
            choiceChipType: 0,
            typeMap: applicantType,
            onSelectionChanged:
            applicantTypeChanged),
            ElevatedButton(
              child: new Text("저장"),
              onPressed: () {Navigator.pop(context);},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                primary:  Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                onPrimary: Colors.white,
              )
            )
          ]
        )
      );
  }

  void applicantTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      applicantType = map;
    });
  }
}

void _showDialog(context){
  showDialog(
      context: context,
      barrierDismissible: false,  
      builder: (BuildContext context) { 
        return AlertDialog(
          title: Text("태그 선택"),
          actions: <Widget>[
            PositionChange()
          ]
        );
      }
  );
}


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

class AgreeContract extends StatefulWidget {
  final String pdfPath;
  final int index;
  AgreeContract({this.pdfPath, this.index});
  @override
  _AgreeContractState createState() => _AgreeContractState();
}

class _AgreeContractState extends State<AgreeContract> {
  bool _value = false;
  int index;
  bool _isLoading = true;

  String pdfPath;
  @override
  void initState() {
    super.initState();
    index = widget.index;
    pdfPath = widget.pdfPath;

    createFileOfPdfUrl().then((f) {
      setState(() {
        pdfPath = f.path;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width * 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("계약서 조항 ($index)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _value = !_value;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: themeLightOrange),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _value
                                ? Icon(
                                    Icons.check,
                                    size: 10.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 10.0,
                                    color: themeLightOrange,
                                  ),
                          ),
                        ),
                      ),
                    ]))
          ])),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.5,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFView(
                  filePath: pdfPath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  fitPolicy: FitPolicy.BOTH,
                ))
    ]);
  }
}
