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
      // use provider !
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomRouter(false)),
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
      home: Provider.of<CustomRouter>(context).isLoggedin
          ? Routes()
          : LoginPage(),
      // home: Routes(),
      // set theme
      theme: ThemeData(fontFamily: GoogleFonts.notoSans().fontFamily),
    );
  }
}
