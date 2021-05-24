import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/model/member.dart';
import 'package:iruri/pages/home/home.dart';
import 'package:iruri/pages/signup/signup.dart';
import 'package:iruri/pages/state/state_applylist.dart';
import 'package:iruri/provider.dart';
import 'package:iruri/util/data_user.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  UserAPI api;
  Member member;
  Map<String, TextEditingController> infoController =
      new Map<String, TextEditingController>();

  List<bool> select = new List(8);
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 8; i++) {
      select[i] = false;
    }
    api = new UserAPI();

    infoController['email'] = new TextEditingController();
    infoController['password'] = new TextEditingController();
    infoController['nickname'] = new TextEditingController();
    infoController['phoneNumber'] = new TextEditingController();
  }

  @override
  Widget build(BuildContntext) {
    return Container(
        decoration: BoxDecoration(
          border:
              Border.all(width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            emailForm(),
            passwordForm(),
            nameForm(),
            phoneNumberForm(),
            registerButton()
          ],
        ));
  }

  Widget emailForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("아이디")),
          Expanded(
              flex: 5,
              child: TextFormField(
                controller: infoController['email'],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: themeGrayText),
                  hintText: '이메일 형식에 맞게 입력',
                ),
              ))
        ],
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("비밀번호")),
          Expanded(
              flex: 5,
              child: TextFormField(
                controller: infoController['password'],
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: themeGrayText),
                  hintText: '영문 대, 소문자+숫자 8-15자',
                ),
              ))
        ],
      ),
    );
  }

  Widget nameForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("이름")),
          Expanded(
              flex: 5,
              child: TextFormField(
                controller: infoController['nickname'],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: themeGrayText),
                  hintText: '실명 입력',
                ),
              ))
        ],
      ),
    );
  }

  Widget phoneNumberForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("전화번호")),
          Expanded(
              flex: 5,
              child: TextFormField(
                controller: infoController['phoneNumber'],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                  ),
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: themeGrayText),
                  hintText: '하이픈(-) 없이 입력',
                ),
              ))
        ],
      ),
    );
  }

  void setMemberInfo() {
    setState(() {
      member = new Member(
          info: new Info(
              email: infoController['email'].text,
              password: infoController['password'].text,
              phoneNumber: infoController['phoneNumber'].text,
              nickname: infoController['nickname'].text));
    });
  }

  Future<void> postUserInfo() async {
    await api.postNewUserInfo(member);
  }

  Widget registerButton() {
    final routerReader = context.read<CustomRouter>();
    final routerWatcher = context.watch<CustomRouter>();

    return ElevatedButton(
        onPressed: () {
          setMemberInfo();
          postUserInfo();

          updateUserInfo();

          // Provider.of<CustomRouter>(context, listen: false)
          //     .setRegistrationStatus(true);
          // routerReader.navigateTo(routerWatcher.currentPage, '/');
          // Navigator.pop(context);

          // updateUserInfo();
        },
        child: Text("가입하기"),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(top: 11, bottom: 11, left: 21, right: 21),
          primary: Colors.white,
          onPrimary: Color.fromRGBO(0x82, 0x82, 0x82, 1),
          // fixedSize: Size(90, 30),
        ));
  }

  Future<void> updateUserInfo() {
    return showMaterialModalBottomSheet(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        context: context,
        builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 55),
            controller: ModalScrollController.of(context),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.create_outlined,
                              size: 30.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "선택 정보 입력",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87),
                          )
                        ],
                      ),
                      selectOptions(0, "글"),
                      selectOptions(1, "채색"),
                      selectOptions(2, "선화"),
                      selectOptions(3, "콘티"),
                      selectOptions(4, "캐릭터"),
                      selectOptions(5, "그림"),
                      selectOptions(6, "데생"),
                      selectOptions(7, "후보정"),
                    ]))));
  }

  Widget selectOptions(int i, String tags) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              onTap: () {
                setState(() {
                  select[i] = !select[i];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: themeLightOrange),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: select[i]
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
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TagWrapper(tag: tags))
      ]),
    ]));
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AgreeTerm extends StatefulWidget {
  final String content;
  AgreeTerm({this.content});
  @override
  _AgreeTermState createState() => _AgreeTermState();
}

class _AgreeTermState extends State<AgreeTerm> {
  bool _value1 = false;
  bool _value2 = false;

  int index;
  String content;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border:
              Border.all(width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: MediaQuery.of(context).size.width * 1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value1 = !_value1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: themeLightOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _value1
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
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("이용약관 동의(필수)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
          Row(children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value2 = !_value2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: themeLightOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _value2
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
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("개인정보수집 및 이용 동의(필수)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
        ]));
  }
}
