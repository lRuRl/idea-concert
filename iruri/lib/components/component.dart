import 'package:flutter/material.dart';

// light gray 색 구분선
const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //left, top, right, bottom
      child: Column(children: <Widget>[
        divider,
        //프로필 상단 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("프로필 정보", style: TextStyle()),
            Icon(Icons.create_outlined , size: 30),
          ],
        ),
        //프로필 하단 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Container(              //프로필사진 컨테이너
            height: 130, 
            width: 130,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(100, 255, 255, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('Icon-192.png')
          ),
          Column(               //프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
            children: [ 
               Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    width: 50,
                    alignment: Alignment.topLeft,
                    child: Text("닉네임"),
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 25),
                    width: 50,
                    alignment: Alignment.topLeft,
                    child: Text("포지션"),
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    width: 50,
                    alignment: Alignment.topLeft,
                    child: Text("연락처"),
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    width: 50,
                    alignment: Alignment.topLeft,
                    child: Text("이메일"),
                  ),
            ]),
            Column(               //프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
            children: [ 
               Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    alignment: Alignment.topCenter,
                    child: Text("parkjang"),
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 25),
                    alignment: Alignment.topCenter,
                    child: position(), //나중에 포지션별 태그를 넣기 위함
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    alignment: Alignment.topCenter,
                    child: Text("010-XXXX-XXXX"),
                  ),
                   Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    alignment: Alignment.topCenter,
                    child: Text("parkjang@naver.com"),
                  ),
            ]),
        ]),
        divider
      ],)
    );
  }

  //포지션 태그 위젯
  Widget position() {
    return Container(
          child: Text("채색"),
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

