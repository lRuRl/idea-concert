// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// components
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/pages/signup/signup.dart';
// model
import 'package:iruri/model/user.dart';
// provider
import 'package:iruri/provider.dart';
// util
import 'package:iruri/util/api_user.dart';

class UserSigninInfo extends StatefulWidget {
  @override
  _UserSigninInfoState createState() => _UserSigninInfoState();
}

class _UserSigninInfoState extends State<UserSigninInfo> {
  UserAPI api;
  User user;
  bool isChecked;
  Map<String, TextEditingController> infoController =
      new Map<String, TextEditingController>();

  @override
  void initState() {
    super.initState();
    api = new UserAPI();
    isChecked = false;
    infoController['id'] = new TextEditingController();
    infoController['pwd'] = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [getUserInfo(context), loginButton(context)],
      ),
    );
  }

  Widget getUserInfo(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(children: <Widget>[
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              controller: infoController['id'],
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                disabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                fillColor: Colors.white,
                labelStyle:
                    montSesrratTextStyle(textColor: greyText, fontSize: 14),
                labelText: 'Enter e-mail',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: infoController['pwd'],
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                disabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                fillColor: Colors.white,
                labelStyle:
                    montSesrratTextStyle(textColor: greyText, fontSize: 14),
                labelText: 'Enter Password',
              ),
            ),
          ),
        ]));
  }

  Future<User> checkIdPwd() async {
    final id = infoController['id'].text;
    final pwd = infoController['pwd'].text;

    return await api.signIn(id, pwd);
  }

  Widget loginButton(BuildContext context) {
    final routerReader = context.read<CustomRouter>();
    final routerWatcher = context.watch<CustomRouter>();

    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ElevatedButton(
            onPressed: () async {
              var res = await checkIdPwd();
              if (res != null) {
                // set current User
                Provider.of<UserState>(context, listen: false).setUser(res);
                // // set router
                // Provider.of<CustomRouter>(context, listen: false)
                //     .setRegistrationStatus(true);
                routerReader.navigateTo(routerWatcher.currentPage, '/');
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('잘못 입력하셨습니다.')));
              }
            },
            child: Text("로그인", style: buttonWhiteTextStyle),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              padding: paddingH10V10,
              //fixedSize: Size(90, 30),
              primary: primary,
              onPrimary: Colors.white,
            )));
  }
}

Widget appImage(BuildContext context) {
  return Center(
    child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset('assets/default.png')),
  );
}

Widget appName(BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text('IRURI',
          style:
              montSesrratTextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
}

Widget findInfo(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: themeGrayText),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('회원가입'),
            ),
            Text('|', style: TextStyle(color: themeGrayText)),
            TextButton(
              style: TextButton.styleFrom(primary: themeGrayText),
              onPressed: null,
              child: Text('아이디 찾기'),
            ),
            Text('|', style: TextStyle(color: themeGrayText)),
            TextButton(
              style: TextButton.styleFrom(primary: themeGrayText),
              onPressed: null,
              child: Text('비밀번호 찾기'),
            )
          ]));
}

Widget selectLogin(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            snsIcon(context, "구글"),
            snsIcon(context, "네이버"),
            snsIcon(context, "카카오톡"),
            snsIcon(context, "애플"),
          ]));
}

Widget snsIcon(BuildContext context, String type) {
  return Column(
    children: [
      InkWell(
          onTap: () {},
          child: Container(
              child: ClipRRect(
            child: Image.asset(
              'assets/${type}.png',
              width: MediaQuery.of(context).size.width * 0.06,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ))),
      Text(
        "${type} 계정으로\n로그인",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      )
    ],
  );
}
