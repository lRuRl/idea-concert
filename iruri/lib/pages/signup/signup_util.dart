import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/user.dart';
import 'package:iruri/provider.dart';
import 'package:iruri/util/api_user.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  UserAPI api;
  User user;
  Map<String, TextEditingController> infoController =
      new Map<String, TextEditingController>();
  bool _value1 = false;
  bool _value2 = false;
  List<bool> select = [false, false, false, false, false, false, false, false];
  List<String> selectedTags = [];
  @override
  void initState() {
    super.initState();

    api = new UserAPI();

    infoController['email'] = new TextEditingController();
    infoController['password'] = new TextEditingController();
    infoController['nickname'] = new TextEditingController();
    infoController['phoneNumber'] = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
            left: BorderSide(
                width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
            right: BorderSide(
                width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: paddingH20V20,
          children: <Widget>[
            emailForm(),
            passwordForm(),
            nameForm(),
            phoneNumberForm(),
            agreeTerm(),
            defaultImage(context),
            nextButton(),
          ],
        ));
  }

  Widget emailForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("?????????")),
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
                  hintText: '????????? ????????? ?????? ??????',
                ),
              ))
        ],
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("????????????")),
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
                  hintText: '?????? ???, ?????????+?????? 8-15???',
                ),
              ))
        ],
      ),
    );
  }

  Widget nameForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("??????")),
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
                  hintText: '?????? ??????',
                ),
              ))
        ],
      ),
    );
  }

  Widget phoneNumberForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("????????????")),
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
                  hintText: '?????????(-) ?????? ??????',
                ),
              ))
        ],
      ),
    );
  }

  Widget defaultImage(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Image.asset('assets/default.png')));
  }

  void setUserInfo() {
    setState(() {
      user = User(
          id: infoController['email'].text,
          pw: infoController['password'].text,
          profileInfo: ProfileInfo(
            name: infoController['nickname'].text,
            phoneNumber: infoController['phoneNumber'].text,
            roles: selectedTags,
          ));
    });
  }

  Future<void> postUserInfo() async {
    setUserInfo();
    print(user.toJson().toString());
    await api.postNewUserInfo(user);
  }

  Widget nextButton() {
    return TextButton(
        onPressed: () {
          if (_value1 == true && _value2 == true) {
            selectModal();
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('?????? ????????? ???????????????.')));
          }
        },
        child: Text("??????", style: buttonWhiteTextStyle),
        style: TextButton.styleFrom(
            padding: paddingH20V10,
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8))));
  }

  Widget agreeTerm() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 5, color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1))),
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
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: primary),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: _value1
                          ? Icon(
                              Icons.check,
                              size: 20.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 20.0,
                              color: primary,
                            ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("???????????? ??????(??????)",
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
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: primary),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: _value2
                          ? Icon(
                              Icons.check,
                              size: 20.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 20.0,
                              color: primary,
                            ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("?????????????????? ??? ?????? ??????(??????)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left),
            )
          ]),
        ]));
  }

  Future<void> selectModal() {
    return showMaterialModalBottomSheet(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            final routerReader = context.read<CustomRouter>();
            final routerWatcher = context.watch<CustomRouter>();
            Widget selectOptions(int i, String tags) {
              return Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                select[i] = !select[i];
                              });
                              if (select[i]) {
                                selectedTags.add(tags);
                              } else {
                                selectedTags
                                    .removeWhere((element) => element == tags);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: primary),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: select[i]
                                    ? Icon(
                                        Icons.check,
                                        size: 20.0,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 20.0,
                                        color: primary,
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

            return Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 1.3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                FeatherIcons.edit2,
                                size: 24.0,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "?????? ?????? ??????",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87),
                            )
                          ]),
                          TextButton(
                            onPressed: () {
                              postUserInfo()
                                  .then((value) =>
                                      Provider.of<UserState>(context, listen: false)
                                          .setUser(this.user))
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                          SnackBar(content: Text('???????????? ??????!'))));
                              Navigator.pop(context);
                              routerReader.navigateTo(
                                  routerWatcher.currentPage, '/');
                              Navigator.pop(context);
                            },
                            child: Text('????????????', style: bodyTextStyle),
                          ),
                        ],
                      ),
                      selectOptions(0, "?????????"),
                      selectOptions(1, "?????????"),
                      selectOptions(2, "????????????"),
                      selectOptions(3, "????????????"),
                      selectOptions(4, "?????????"),
                      selectOptions(5, "??????"),
                      selectOptions(6, "??????"),
                      selectOptions(7, "?????????"),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextButton(
                              child:
                                  Text("???????????? ??????", style: buttonWhiteTextStyle),
                              style: TextButton.styleFrom(
                                  padding: paddingH10V10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: primary),
                              onPressed: () {
                                postUserInfo()
                                    .then((value) =>
                                        Provider.of<UserState>(context, listen: false)
                                            .setUser(this.user))
                                    .then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('???????????? ??????!'))));
                                Navigator.pop(context);
                                routerReader.navigateTo(
                                    routerWatcher.currentPage, '/');
                                Navigator.pop(context);
                              }))
                    ]));
          });
        });
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
