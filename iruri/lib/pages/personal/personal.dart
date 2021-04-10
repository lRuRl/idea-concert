import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
 ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children :<Widget>[
        Text("PERSONAL"), 
        myProfileContainer(),
      ])
    );
  }

   Widget myProfileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //left, top, right, bottom
      child: Column(children: <Widget>[
        Row(               //프로필 위젯 상단 바 왼쪽 텍스트 부분
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "프로필 정보",
              style: TextStyle(
                /*
                * 추후 디자인
                *
                */
              )
              ),
              /*
              * 상단 바 오른쪽엔 편집모양 아이콘
              * 편집모양 아이콘 넣어야 해요
              */
            Image.asset('Icon-192.png', width: 30, height: 30),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[   // 그 아래 contents 부분
          Container(              //프로필사진 컨테이너
            height: 130, 
            width: 130,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('Icon-192.png'),
          ),
          Column(               //프로필 내용 컨테이너
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("닉네임"),
              Text("포지션"),
              Text("연락처"),
              Text("이메일")
          ]),
          Column()
        ],)
      ],)
    );
  }
}
