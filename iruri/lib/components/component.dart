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
      margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //left, top, right, bottom
      child: Column(children: <Widget>[
        divider,
        Row(               //프로필 위젯 상단 왼쪽 텍스트 부분
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("프로필 정보", style: TextStyle()),
              /*
              * 상단 오른쪽엔 수정하기 아이콘
              * 이미지 나중에 바꾸기
              */
            Image.asset('Icon-192.png', width: 30, height: 30),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Container(              //프로필사진 컨테이너
            height: 130, 
            width: 130,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('Icon-192.png')
          ),
          Column(               //프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              nickName(),
              position(),
              phoneNum(),
              email(),
          ]),
        ]),
        divider
      ],)
      
    );
  }

  //닉네임 나타냄(임시)
  Widget nickName(){
    return Container(
      child: Row(
        children: [
        Text("닉네임", style: TextStyle(),),
        Text("석운장", style: TextStyle(),)
      ],)
    );
  }

  // 포지션 나타냄(임시)
  Widget position(){
    return Container(
      child: Row(children: [
        Text("포지션", style: TextStyle(),),
        /*
        * 포지션을 그리드뷰로
        *
        */
        Text("그리드뷰 들어갈 자리")
      ])
    );
  }

  //전화번호 나타냄(임시)
  Widget phoneNum(){
    return Container(
      child: Row(
        children: [
        Text("연락처", style: TextStyle(),),
        Text("010-1111-1111", style: TextStyle(),)
      ],)
    );
  }

  //이메일 나타냄(임시)
  Widget email(){
    return Container(
      child: Row(
        children: [
        Text("이메일", style: TextStyle(),),
        Text("rrrrrrrr@gmail.com", style: TextStyle(),)
      ],)
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

