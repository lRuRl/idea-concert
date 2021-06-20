import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iruri/pages/signup/signin.dart';
// provicer
import 'package:iruri/provider.dart';
import 'package:provider/provider.dart';
// routes
import 'package:iruri/routes.dart';

void main() {
  runApp(

      /// the main part of provider tree
      /// [CustomRouter] manage nested page routing
      /// [UserState] manage current user, who has signed-in at the first time
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomRouter()),
      ChangeNotifierProvider(create: (context) => UserState())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 우측 상단에 DEBUG 표시 제거
      debugShowCheckedModeBanner: false,
      /// check if the [currentUser] is null
      /// if it is null then it means none of user exists
      /// and go on to the LoginPage
      home: Provider.of<UserState>(context).currentUser != null
          ? Routes()
          : LoginPage(),
      // set theme
      theme: ThemeData(fontFamily: GoogleFonts.notoSans().fontFamily),
    );
  }
}
