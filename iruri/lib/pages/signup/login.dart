import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/pages/signup/login_utils.dart';
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ScrollController scrollController;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    textEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                appImage(context),
                appName(context),
                getUserInfo(context),
                loginButton(context),
                findInfo(context)
              ],
            ),
          ),
        ));
  }
}
