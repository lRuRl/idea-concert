import 'package:flutter/material.dart';
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
      ChangeNotifierProvider(create: (context) => CustomRouter()),
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
      home: Routes(),
    );
  }
}
